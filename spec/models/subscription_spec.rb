require 'rails_helper'

RSpec.describe Subscription do
  describe 'validations' do
    it { should validate_presence_of :number_of_subscribers }
    it { should validate_presence_of :repository }
    it { should validate_presence_of :subscriber }
  end
end
