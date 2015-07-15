require 'rails_helper'

describe 'feed routes' do
  it 'routes repos with periods in their name' do
    feed_route = {
      format: :atom,
      controller: 'feeds',
      action: 'show',
      owner: 'owner',
      repo: 'com.repo'
    }

    expect(get('/feeds/owner/com.repo')).to route_to(feed_route)
  end

  it 'routes normal named repos' do
    feed_route = {
      format: :atom,
      controller: 'feeds',
      action: 'show',
      owner: 'owner',
      repo: 'repo'
    }

    expect(get('/feeds/owner/repo')).to route_to(feed_route)
  end
end
