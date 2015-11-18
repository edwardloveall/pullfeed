require 'rails_helper'

describe Analytics do
  describe '#requested_feed' do
    before(:each) do
      allow(KeenAnalytics).to receive(:requested_feed)
      allow(MixpanelAnalytics).to receive(:requested_feed)
    end

    it 'delegates to KeenAnalytics' do
      FakeController.new.track_test

      expect(KeenAnalytics).to have_received(:requested_feed)
    end
  end

  class FakeRequest
    attr_reader :remote_ip
  end

  class FakeController
    include Analytics

    def track_test
      repository_params = { owner: 'github', repo: 'code' }
      requested_feed(repository_params)
    end

    def request
      FakeRequest.new
    end
  end
end
