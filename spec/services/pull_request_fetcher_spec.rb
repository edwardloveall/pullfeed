require 'rails_helper'

describe PullRequestFetcher do
  context 'when repository has pull requests' do
    it 'fetches the open PRs from github' do
      params = { owner: 'github', repo: 'code', q: nil }
      url = 'https://api.github.com/repos/github/code/pulls'
      stub_github_response(url, fixture_load('github', 'pulls.json'))

      PullRequestFetcher.perform(params)

      expect(WebMock).to have_requested(:get, url)
    end

    it 'returns the data needed to make a feed' do
      params = { owner: 'github', repo: 'code', q: nil }
      url = 'https://api.github.com/repos/github/code/pulls'
      stub_github_response(url, fixture_load('github', 'pulls.json'))

      result = PullRequestFetcher.perform(params)[:pull_requests]
      pull = result.first

      expect(pull['body']).to eq('A very important pull request that makes the `code` much better.')
      expect(pull['created_at']).to eq('2015-05-05T07:50:40Z')
      expect(pull['html_url']).to eq('https://github.com/github/code/pull/564')
      expect(pull['title']).to eq('Improve the code very much')
      expect(pull['user']['login']).to eq('john-doe')
    end

    it 'returns the data needed to make a Repository' do
      params = { owner: 'github', repo: 'code', q: nil }
      url = 'https://api.github.com/repos/github/code/pulls'
      stub_github_response(url, fixture_load('github', 'pulls.json'))

      result = PullRequestFetcher.perform(params)[:repository]

      expect(result['description']).to eq('A repo with some really good code.')
      expect(result['html_url']).to eq('https://github.com/github/code')
      expect(result['name']).to eq('code')
      expect(result['owner']['login']).to eq('github')
    end

    it 'fetches the open PRs from github when searching' do
      params = { owner: 'github', repo: 'code', q: 'needle' }
      url = search_url(params)
      stub_github_response(url, fixture_load('github', 'search.json'))
      repo_url = 'https://api.github.com/repos/github/code'
      stub_github_response(repo_url, fixture_load('github', 'repository.json'))

      PullRequestFetcher.perform(params)

      expect(WebMock).to have_requested(:get, url)
      expect(WebMock).to have_requested(:get, repo_url)
    end

    it 'returns the data needed to make a feed when searching' do
      params = { owner: 'github', repo: 'code', q: 'needle' }
      url = search_url(params)
      stub_github_response(url, fixture_load('github', 'search.json'))
      repo_url = 'https://api.github.com/repos/github/code'
      stub_github_response(repo_url, fixture_load('github', 'repository.json'))

      result = PullRequestFetcher.perform(params)[:pull_requests]
      pull = result.first

      expect(pull['body']).to eq('...')
      expect(pull['created_at']).to eq('2009-07-12T20:10:41Z')
      expect(pull['html_url']).to eq('https://github.com/batterseapower/pinyin-toolkit/issues/132')
      expect(pull['title']).to eq('Line Number Indexes Beyond 20 Not Displayed')
      expect(pull['user']['login']).to eq('Nick3C')
    end

    it 'returns the data needed to make a Repository when searching' do
      params = { owner: 'github', repo: 'code', q: 'needle' }
      url = search_url(params)
      stub_github_response(url, fixture_load('github', 'search.json'))
      repo_url = 'https://api.github.com/repos/github/code'
      stub_github_response(repo_url, fixture_load('github', 'repository.json'))

      result = PullRequestFetcher.perform(params)[:repository]

      expect(result['description']).to eq('A repo with some really good code.')
      expect(result['html_url']).to eq('https://github.com/github/code')
      expect(result['name']).to eq('code')
      expect(result['owner']['login']).to eq('github')
    end
  end

  context 'when repository has no pull requests' do
    it 'fetches the repository instead after fetching the pulls url' do
      params = { owner: 'github', repo: 'code', q: nil }
      pull_url = 'https://api.github.com/repos/github/code/pulls'
      stub_github_response(pull_url, fixture_load('github', 'pulls_empty.json'))
      repo_url = 'https://api.github.com/repos/github/code'
      stub_github_response(repo_url, fixture_load('github', 'repository.json'))

      PullRequestFetcher.perform(params)

      expect(WebMock).to have_requested(:get, pull_url)
      expect(WebMock).to have_requested(:get, repo_url)
    end

    it 'returns the data needed to make a Repository' do
      params = { owner: 'github', repo: 'code', q: nil }
      pull_url = 'https://api.github.com/repos/github/code/pulls'
      stub_github_response(pull_url, fixture_load('github', 'pulls_empty.json'))
      repo_url = 'https://api.github.com/repos/github/code'
      stub_github_response(repo_url, fixture_load('github', 'repository.json'))

      results = PullRequestFetcher.perform(params)
      result = results[:repository]

      expect(result['created_at']).to eq('2011-05-09T22:53:13Z')
      expect(result['description']).to eq('A repo with some really good code.')
      expect(result['html_url']).to eq('https://github.com/github/code')
      expect(result['name']).to eq('code')
      expect(result['owner']['login']).to eq('github')

      result = results[:pull_requests]
      expect(result).to be_empty
    end
  end

  context "when a repository doesn't exist" do
    it 'raises a not found error' do
      stub_request(:get, bad_pulls_url).
        to_return(body: fixture_load('github', '404.json'),
                  headers: { 'Content-Type' => 'application/json' },
                  status: 404)

      expect {
        PullRequestFetcher.perform(owner: 'foo', repo: 'bar', q: nil)
      }.to raise_error(PullRequestFetcher::RepositoryNotFound)
    end

    it 'raises a not found error when searching' do
      stub_github_response(search_url(owner: 'foo', repo: 'bar', q: 'baz'), '{"items":[]}')
      stub_request(:get, bad_repo_url).
        to_return(body: fixture_load('github', '404.json'),
                  headers: { 'Content-Type' => 'application/json' },
                  status: 404)

      expect {
        PullRequestFetcher.perform(owner: 'foo', repo: 'bar', q: 'baz')
      }.to raise_error(PullRequestFetcher::RepositoryNotFound)
    end
  end

  it 'requests the URL with authorization headers' do
    token = '0123456789abcdef'
    ENV['GITHUB_ACCESS_TOKEN'] = token
    params = { owner: 'github', repo: 'code', q: nil }
    url = 'https://api.github.com/repos/github/code/pulls'
    stub_github_response(url, fixture_load('github', 'pulls.json'))

    PullRequestFetcher.perform(params)

    expect(WebMock).to have_requested(:get, url).
                    with(headers: { 'Authorization' => "token #{token}" })
  end

  it 'requests the URL with User Agent' do
    username = 'edwardloveall'
    ENV['GITHUB_USERNAME'] = username
    params = { owner: 'github', repo: 'code', q: nil }
    url = 'https://api.github.com/repos/github/code/pulls'
    stub_github_response(url, fixture_load('github', 'pulls.json'))

    PullRequestFetcher.perform(params)

    expect(WebMock).to have_requested(:get, url).
                    with(headers: { 'User-Agent' => username })
  end

  def stub_github_response(url, response)
    stub_request(:get, url).
      to_return(body: response,
                headers: { 'Content-Type' => 'application/json; charset=utf-8' })
  end

  def github_url(owner:, repo:)
    "https://api.github.com/repos/#{owner}/#{repo}/pulls"
  end

  def bad_pulls_url
    'https://api.github.com/repos/foo/bar/pulls'
  end

  def bad_repo_url
    'https://api.github.com/repos/foo/bar'
  end

  def search_url(owner:, repo:, q:)
    "https://api.github.com/search/issues?per_page=100&q=repo:#{owner}/#{repo}+is:pr+is:open+#{q}&sort=created"
  end
end
