require 'rails_helper'

describe PrFetcher do
  it 'fetches the open PRs from github' do
    params = { owner: 'thoughtbot', repo: 'suspenders' }
    url = github_url(params)
    stub_github_response(url)

    PrFetcher.perform(params)

    expect(WebMock).to have_requested(:get, url)
  end

  it 'returns the data needed to make a feed' do
    params = { owner: 'thoughtbot', repo: 'suspenders' }
    url = github_url(params)
    stub_github_response(url)

    result = PrFetcher.perform(params)
    pull = result.first

    expect(pull[:link]).to eq('https://github.com/thoughtbot/suspenders/pull/564')
    expect(pull[:title]).to eq('Do not touch $HOST in .env')
    expect(pull[:description]).to eq("The .env should not touch $HOST, since that is controlled by the shell\r\nand changing it can lead to surprises, failures, and even crashes.")
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
