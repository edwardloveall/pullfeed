require 'keen'
load 'app/services/keen_analytics.rb'

describe KeenAnalytics do
  describe '.requested_feed' do
    it 'calls Keen.publish' do
      allow(Keen).to receive(:publish)

      KeenAnalytics.requested_feed(owner: 'github', repo: 'code')

      expect(Keen).to have_received(:publish)
    end
  end
end
