require 'rails_helper'

describe PullRequestSerializer do
  describe '.perform' do
    it 'returns a pull request' do
      pull_request = PullRequestSerializer.perform(data)

      expect(pull_request).to be_a(PullRequest)
    end

    it 'fills the pull request with attributes' do
      pull_request = PullRequestSerializer.perform(data)

      expect(pull_request.author).to eq('john-doe')
      expect(pull_request.created_at).to eq(Time.parse('2015-05-05T07:50:40Z'))
      expect(pull_request.description).to eq('A very important pull request that makes the `code` much better.')
      expect(pull_request.link).to eq('https://github.com/github/code/pull/564')
      expect(pull_request.title).to eq('Improve the code very much')
    end
  end

  def data
    @_data ||= JSON.parse(fixture_load('github', 'pulls.json')).first
  end
end
