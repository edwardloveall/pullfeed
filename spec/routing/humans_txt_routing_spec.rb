require 'rails_helper'

describe 'humans.txt routes' do
  it 'routes /humans.txt to /pages/humans.txt' do
    high_voltage_home = {
      action: 'show',
      controller: 'high_voltage/pages',
      id: 'humans'
    }

    expect(get('/humans.txt')).to route_to(high_voltage_home)
  end
end
