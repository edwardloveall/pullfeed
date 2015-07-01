require 'rails_helper'

describe Repository do
  describe 'created_at=' do
    it 'transforms the string into a Time' do
      repository = Repository.new(created_at: '2015-05-05T07:50:40Z')

      expect(repository.created_at).to be_a(DateTime)
    end
  end
end
