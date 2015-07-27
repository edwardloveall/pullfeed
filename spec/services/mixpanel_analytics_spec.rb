require 'mixpanel-ruby'
load 'app/services/mixpanel_analytics.rb'

describe MixpanelAnalytics do
  describe '#requested_feed' do
    it 'calls Mixpanel::Tracker.track' do
      tracker = spy('tracker')
      allow(Mixpanel::Tracker).to receive(:new).and_return(tracker)

      FakeController.new.track_test

      expect(tracker).to have_received(:track)
    end
  end

  class FakeRequest;
    attr_reader :remote_ip
  end

  class FakeController
    include MixpanelAnalytics

    def track_test
      requested_feed(owner: 'github', repo: 'code')
    end

    def request
      FakeRequest.new
    end
  end
end
