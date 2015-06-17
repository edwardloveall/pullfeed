require 'rails_helper'

describe Repository do
  describe 'created_at=' do
    it 'transforms the string into a Time' do
      repository = Repository.new(created_at: '2015-05-05T07:50:40Z')

      expect(repository.created_at).to be_a(DateTime)
    end
  end

  describe '#sorted_pull_requests' do
    it 'returns pull requests in newest to oldest order' do
      older = build(:pull_request, created_at: '2000-05-20T00:00:00Z')
      newer = build(:pull_request, created_at: '2000-05-21T00:00:00Z')
      repository = build(:repository, pull_requests: [older, newer])

      expect(repository.sorted_pull_requests).to eq([newer, older])
    end
  end
end
