require 'rails_helper'

RSpec.describe SubscriptionLogger do
  describe '.perform' do
    it 'creates a Subscription' do
      allow(SubscriptionParser).
        to receive(:perform).
        and_return(number_of_subscribers: 1, subscriber: 'Feedbin')
      request = double(:request, params: { owner: 'github', repo: 'code' })

      expect(Subscription.count).to eq(0)

      SubscriptionLogger.perform(request)

      expect(Subscription.count).to eq(1)
    end

    it 'calls SubscriptionParser' do
      allow(SubscriptionParser).
        to receive(:perform).
        and_return(number_of_subscribers: 1, subscriber: 'Feedbin')
      allow(Subscription).to receive(:create)
      request = double(:request, params: {})

      SubscriptionLogger.perform(request)

      expect(SubscriptionParser).to have_received(:perform)
    end

    it 'updates a Subscription if one already exists for the same repository and subscriber' do
      subscription = create(:subscription,
                            number_of_subscribers: 1,
                            subscriber: 'foo',
                            repository: 'github/code')
      allow(SubscriptionParser).
        to receive(:perform).
        and_return(number_of_subscribers: 3, subscriber: 'foo')
      request = double(:request, params: { owner: 'github', repo: 'code' })

      result = SubscriptionLogger.perform(request)
      subscription.reload

      expect(subscription.number_of_subscribers).to eq(3)
      expect(Subscription.count).to eq(1)
    end
  end
end
