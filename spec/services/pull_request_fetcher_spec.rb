require 'rails_helper'

describe PullRequestFetcher do
  it 'fetches the open PRs from github' do
    params = { owner: 'thoughtbot', repo: 'suspenders' }
    url = github_url(params)
    stub_github_response(url)

    PullRequestFetcher.perform(params)

    expect(WebMock).to have_requested(:get, url)
  end

  it 'returns the data needed to make a feed' do
    params = { owner: 'thoughtbot', repo: 'suspenders' }
    url = github_url(params)
    stub_github_response(url)

    result = PullRequestFetcher.perform(params)
    pull = result.first

    expect(pull['html_url']).to eq('https://github.com/github/code/pull/564')
    expect(pull['title']).to eq('Improve the code very much')
    expect(pull['body']).to eq("A very important pull request that makes the code much better.")
  end

  def stub_github_response(url)
    stub_request(:get, url).
      to_return(body: fixture_load('github', 'pulls.json'),
                headers: { 'Content-Type' => 'application/json; charset=utf-8' })
  end

  def github_url(owner:, repo:)
    "https://api.github.com/repos/#{owner}/#{repo}/pulls"
  end
end
