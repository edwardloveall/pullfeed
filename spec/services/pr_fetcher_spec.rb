require 'rails_helper'

describe PrFetcher do
  it 'fetches the open PRs from github' do
    url = 'https://api.github.com/repos/thoughtbot/suspenders/pulls'
    allow(HTTParty).to receive(:get).with(url).
      and_return(fixture_load('github', 'pulls.json'))
    params = { owner: 'thoughtbot', repo: 'suspenders' }

    PrFetcher.perform(params)

    expect(HTTParty).to have_received(:get).with(url)
  end
end
