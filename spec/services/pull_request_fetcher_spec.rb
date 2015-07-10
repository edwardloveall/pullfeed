require 'rails_helper'

describe PullRequestFetcher do
  context 'when repository has pull requests' do
    it 'fetches the open PRs from github' do
      params = { owner: 'github', repo: 'code' }
      url = 'https://api.github.com/repos/github/code/pulls'
      stub_github_response(url, fixture_load('github', 'pulls.json'))

      PullRequestFetcher.perform(params)

      expect(WebMock).to have_requested(:get, url)
    end

    it 'returns the data needed to make a feed' do
      params = { owner: 'github', repo: 'code' }
      url = 'https://api.github.com/repos/github/code/pulls'
      stub_github_response(url, fixture_load('github', 'pulls.json'))

      result = PullRequestFetcher.perform(params)
      pull = result.first

      expect(pull['body']).to eq('A very important pull request that makes the `code` much better.')
      expect(pull['created_at']).to eq('2015-05-05T07:50:40Z')
      expect(pull['html_url']).to eq('https://github.com/github/code/pull/564')
      expect(pull['title']).to eq('Improve the code very much')
      expect(pull['user']['login']).to eq('john-doe')
    end
  end

  context 'when repository has no pull requests' do
    it 'fetches the repository instead after fetching the pulls url' do
      params = { owner: 'github', repo: 'code' }
      pull_url = 'https://api.github.com/repos/github/code/pulls'
      stub_github_response(pull_url, fixture_load('github', 'pulls_empty.json'))
      repo_url = 'https://api.github.com/repos/github/code'
      stub_github_response(repo_url, fixture_load('github', 'repository.json'))

      PullRequestFetcher.perform(params)

      expect(WebMock).to have_requested(:get, pull_url)
      expect(WebMock).to have_requested(:get, repo_url)
    end

    it 'returns the data needed to make a Repository' do
      params = { owner: 'github', repo: 'code' }
      pull_url = 'https://api.github.com/repos/github/code/pulls'
      stub_github_response(pull_url, fixture_load('github', 'pulls_empty.json'))
      repo_url = 'https://api.github.com/repos/github/code'
      stub_github_response(repo_url, fixture_load('github', 'repository.json'))

      result = PullRequestFetcher.perform(params)

      expect(result['created_at']).to eq('2011-05-09T22:53:13Z')
      expect(result['description']).to eq('A repo with some really good code.')
      expect(result['html_url']).to eq('https://github.com/github/code')
      expect(result['name']).to eq('code')
      expect(result['owner']['login']).to eq('github')
    end
  end

  def stub_github_response(url, response)
    stub_request(:get, url).
      to_return(body: response,
                headers: { 'Content-Type' => 'application/json; charset=utf-8' })
  end

  def github_url(owner:, repo:)
    "https://api.github.com/repos/#{owner}/#{repo}/pulls"
  end
end
