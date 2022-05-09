require 'rails_helper'

describe RepositorySerializer do
  describe '.perform' do
    context 'if passing in pull request data' do
      it 'returns a repository' do
        repository = RepositorySerializer.perform({ repository: repository_data, pull_requests: pulls })

        expect(repository).to be_a(Repository)
      end

      it 'fills the repository with attributes' do
        repository = RepositorySerializer.perform({ repository: repository_data, pull_requests: pulls })

        expect(repository.created_at).to eq(Time.parse('2015-05-05T07:50:40Z'))
        expect(repository.description).to eq('A repo with some really good code.')
        expect(repository.link).to eq('https://github.com/github/code')
        expect(repository.owner).to eq('github')
        expect(repository.title).to eq('code')
      end

      it 'serializes pull requests' do
        pull_request = pulls.first
        allow(PullRequestSerializer).to receive(:perform).and_call_original

        repository = RepositorySerializer.perform({ repository: repository_data, pull_requests: pulls })

        expect(PullRequestSerializer).to have_received(:perform).with(pull_request)
        expect(repository.pull_requests.first).to be_a(PullRequest)
      end
    end

    context 'if passing in only repo data' do
      it 'returns a repository' do
        repository = RepositorySerializer.perform({ repository: repository_data, pull_requests: [] })

        expect(repository).to be_a(Repository)
      end

      it 'fills the repository with attributes' do
        repository = RepositorySerializer.perform({ repository: repository_data, pull_requests: [] })

        expect(repository.created_at).to eq(Time.parse('2011-05-09T22:53:13Z'))
        expect(repository.description).to eq('A repo with some really good code.')
        expect(repository.link).to eq('https://github.com/github/code')
        expect(repository.owner).to eq('github')
        expect(repository.title).to eq('code')
      end

      it 'does not have pull requests' do
        repository = RepositorySerializer.perform({ repository: repository_data, pull_requests: [] })

        expect(repository.pull_requests).to be_empty
      end
    end
  end

  def pulls
    @_pulls ||= JSON.parse(fixture_load('github', 'pulls.json'))
  end

  def repository_data
    @_repo ||= JSON.parse(fixture_load('github', 'repository.json'))
  end
end
