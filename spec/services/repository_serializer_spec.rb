require 'rails_helper'

describe RepositorySerializer do
  describe '.perform' do
    it 'returns a repository' do
      repository = RepositorySerializer.perform(data)

      expect(repository).to be_a(Repository)
    end

    it 'fills the repository with attributes' do
      repository = RepositorySerializer.perform(data)

      expect(repository.created_at).to eq(Time.parse('2015-05-05T07:50:40Z'))
      expect(repository.description).to eq('A repo with some really good code.')
      expect(repository.link).to eq('https://github.com/github/code')
      expect(repository.owner).to eq('github')
      expect(repository.title).to eq('code')
    end

    it 'serializes pull requests' do
      pull_request = data.first
      allow(PullRequestSerializer).to receive(:perform).and_call_original

      repository = RepositorySerializer.perform(data)

      expect(PullRequestSerializer).to have_received(:perform).with(pull_request)
      expect(repository.pull_requests.first).to be_a(PullRequest)
    end
  end

  def data
    @_data ||= JSON.parse(fixture_load('github', 'pulls.json'))
  end
end
