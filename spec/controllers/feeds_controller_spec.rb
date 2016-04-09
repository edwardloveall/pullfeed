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
      data = {}
      repository = build(:repository)
      allow(PullRequestFetcher).to receive(:perform).and_return(data)
      allow(RepositorySerializer).to receive(:perform).and_return(repository)
      params = { owner: 'github', repo: 'code' }

      get :show, params.merge(format: :atom)

      expect(RepositorySerializer).to have_received(:perform).with(data)
    end

    it 'creates a new Subscription' do
      expect(Subscription.count).to be(0)

      repository = build(:repository)

      allow(PullRequestFetcher).to receive(:perform)
      allow(RepositorySerializer).to receive(:perform).and_return(repository)
      params = { owner: 'github', repo: 'code' }

      get :show, params.merge(format: :atom)

      expect(Subscription.count).to eq(1)
    end
  end
end
