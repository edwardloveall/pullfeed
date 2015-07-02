require 'rails_helper'

describe PullRequest do
  describe '#guid' do
    it 'returns the link for the pull request' do
      pull_request = build(:pull_request)

      expect(pull_request.guid).to be
      expect(pull_request.guid).to eq(pull_request.link)
    end
  end
end
