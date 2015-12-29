require 'rails_helper'

describe RepositoryFetcher do
  it 'fetches the repository info from github' do
    params = { owner: 'github', repo: 'code' }
    url = github_url(params)
    stub_github_response(url)

    RepositoryFetcher.perform(params)

    expect(WebMock).to have_requested(:get, url)
  end

  it 'returns the data needed to make a repository object' do
    params = { owner: 'github', repo: 'code' }
    url = github_url(params)
    stub_github_response(url)

    result = RepositoryFetcher.perform(params)

    expect(result['name']).to eq('code')
    expect(result['owner']['login']).to eq('github')
    expect(result['description']).to eq('A repo with some really good code.')
    expect(result['created_at']).to eq('2011-05-09T22:53:13Z')
    expect(result['html_url']).to eq('https://github.com/github/code')
  end

  it 'requests the URL with authorization' do
    token = '0123456789abcdef'
    ENV['GITHUB_ACCESS_TOKEN'] = token
    params = { owner: 'github', repo: 'code' }
    url = github_url(params)
    stub_github_response(url)

    RepositoryFetcher.perform(params)

    expect(WebMock).to have_requested(:get, url).
                    with(headers: { 'Authorization' => "token #{token}" })
  end

  def stub_github_response(url)
    stub_request(:get, url).
      to_return(body: fixture_load('github', 'repository.json'),
                headers: { 'Content-Type' => 'application/json; charset=utf-8' })
  end

  def github_url(owner:, repo:)
    "https://api.github.com/repos/#{owner}/#{repo}"
  end
end
