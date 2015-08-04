require 'mixpanel-ruby'
load 'app/services/mixpanel_analytics.rb'

describe MixpanelAnalytics do
  describe '.requested_feed' do
    it 'calls Mixpanel::Tracker.track' do
      request = FakeRequest.new
      tracker = spy('tracker')
      allow(Mixpanel::Tracker).to receive(:new).and_return(tracker)

      MixpanelAnalytics.requested_feed(owner: 'github',
                                       repo: 'code',
                                       request: request)

      expect(tracker).to have_received(:track)
    end
  end

  class FakeRequest
    attr_reader :remote_ip
  end
end
