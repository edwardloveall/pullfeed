require 'rails_helper'

describe 'homepage routes' do
  it 'routes / to /pages/home' do
    high_voltage_home = {
      action: 'show',
      controller: 'high_voltage/pages',
      id: 'home'
    }

    expect(get('/')).to route_to(high_voltage_home)
  end
end
