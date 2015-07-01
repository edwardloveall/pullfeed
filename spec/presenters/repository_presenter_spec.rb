require 'rails_helper'

describe RepositoryPresenter do
  describe 'delegations' do
    it 'delegates methods to its repository' do
      repository = build(:repository)
      presenter = RepositoryPresenter.new(repository)

      expect(presenter.created_at).to eq(repository.created_at)
      expect(presenter.description).to eq(repository.description)
      expect(presenter.link).to eq(repository.link)
      expect(presenter.owner).to eq(repository.owner)
      expect(presenter.pull_requests).to eq(repository.pull_requests)
      expect(presenter.title).to eq(repository.title)
    end
  end

  describe '#descriptive_title' do
    it 'returns the owner, title, and "pull requests"' do
      repository = build(:repository, owner: 'github', title: 'code')
      presenter = RepositoryPresenter.new(repository)

      expect(presenter.descriptive_title).to eq('github/code pull requests')
    end
  end

  describe '#sorted_pull_requests' do
    it 'returns pull requests in newest to oldest order' do
      older = build(:pull_request, created_at: '2000-05-20T00:00:00Z')
      newer = build(:pull_request, created_at: '2000-05-21T00:00:00Z')
      repository = build(:repository, pull_requests: [older, newer])

      presenter = RepositoryPresenter.new(repository)

      expect(presenter.sorted_pull_requests).to eq([newer, older])
    end
  end

  describe '#presented_pull_requests' do
    it 'returns pull requests wrapped in their presenter' do
      request = build(:pull_request)
      repository = build(:repository, pull_requests: [request])

      presenter = RepositoryPresenter.new(repository)
      presented_request = presenter.presented_pull_requests.first

      expect(presented_request).to be_a(PullRequestPresenter)
      expect(presented_request.pull_request).to eq(request)
    end
  end
end
