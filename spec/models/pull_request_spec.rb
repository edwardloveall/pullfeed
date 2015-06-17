require 'active_model'
load 'app/models/pull_request.rb'

describe PullRequest do
  describe '#created_at=' do
    it 'transforms the string into a Time' do
      pull_request = PullRequest.new(created_at: '2015-05-05T07:50:40Z')

      expect(pull_request.created_at).to be_a(DateTime)
    end
  end
end
