require 'rails_helper'

RSpec.describe RepositoryFetch do
  describe 'validations' do
    it { should validate_presence_of :owner }
    it { should validate_presence_of :repo }
  end
end
