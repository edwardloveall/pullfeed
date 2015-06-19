require 'rails_helper'

describe PullRequest do
  describe '#created_at=' do
    it 'transforms the string into a Time' do
      pull_request = build(:pull_request, created_at: '2015-05-05T07:50:40Z')

      expect(pull_request.created_at).to be_a(DateTime)
    end
  end

  describe '#guid' do
    it 'returns the link for the pull request' do
      pull_request = build(:pull_request)

      expect(pull_request.guid).to be
      expect(pull_request.guid).to eq(pull_request.link)
    end
  end

end
