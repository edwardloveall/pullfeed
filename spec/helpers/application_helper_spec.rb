require 'rails_helper'

describe ApplicationHelper do
  describe 'last_updated_date' do
    it 'returns the date of the last commit' do
      allow(Kernel).to receive('`').
                       with('git show -s --format=%ad master').
                       and_return("Thu Jul 1 21:59:45 2015 -0400\n")

      expect(helper.last_updated_date).to eq('2015/07/01')
    end
  end
end
