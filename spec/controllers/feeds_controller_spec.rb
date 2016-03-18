require 'rails_helper'

RSpec.describe FeedsController do
  describe '#show' do
    it 'calls PullRequestFetcher' do
      data = JSON.parse(fixture_load('github', 'pulls.json'))
      allow(PullRequestFetcher).to receive(:perform).and_return(data)
      params = { owner: 'github', repo: 'code' }

      get :show, params.merge(format: :atom)

      expect(PullRequestFetcher).
        to have_received(:perform).with(hash_including(params))
    end

    it 'calls RepositorySerializer' do
      data = JSON.parse(fixture_load('github', 'pulls.json'))
      allow(PullRequestFetcher).to receive(:perform).and_return(data)
      allow(RepositorySerializer).to receive(:perform)
      params = { owner: 'github', repo: 'code' }

      get :show, params.merge(format: :atom)

      expect(RepositorySerializer).to have_received(:perform).with(data)
    end

    it 'creates a new RepositoryFetch' do
      expect(RepositoryFetch.count).to be(0)

      allow(PullRequestFetcher).to receive(:perform)
      allow(RepositorySerializer).to receive(:perform)
      params = { owner: 'github', repo: 'code' }

      get :show, params.merge(format: :atom)

      expect(RepositoryFetch.count).to eq(1)
    end
  end
end
