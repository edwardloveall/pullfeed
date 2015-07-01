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
      expect(presenter.sorted_pull_requests).to eq(repository.sorted_pull_requests)
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
end
