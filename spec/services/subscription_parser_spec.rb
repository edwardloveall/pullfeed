require 'rails_helper'

describe SubscriptionParser do
  describe '.perform' do
    context 'when both subscriber count and service is known' do
      it 'returns a subscriber count and service' do
        request = double(
          :request,
          user_agent: 'Bloglines/3.0-rho (http://www.bloglines.com; 3 subscribers)'
        )

        result = SubscriptionParser.perform(request)

        expect(result).to eq(number_of_subscribers: 3, subscriber: 'Bloglines')
      end
    end

    context 'when subscriber is unknown' do
      it 'returns subscriber count and ip address' do
        request = double(
          :request,
          user_agent: 'foobar (3 subscribers)',
          ip: '12.34.56.78'
        )

        result = SubscriptionParser.perform(request)

        expect(result).to eq(number_of_subscribers: 3,
                             subscriber: '12.34.56.78')
      end
    end

    context 'when user agent is blank' do
      it 'returns subscriber count and ip address' do
        request = double(
          :request,
          user_agent: nil,
          ip: '12.34.56.78'
        )

        result = SubscriptionParser.perform(request)

        expect(result).to eq(number_of_subscribers: 1,
                             subscriber: '12.34.56.78')
      end
    end

    context 'when subscriber count is unknown' do
      it 'returns 1 and the subscriber' do
        request = double(
          :request,
          user_agent: 'Mozilla/5.0 (compatible; inoreader.com-like FeedFetcher-Google)'
        )

        result = SubscriptionParser.perform(request)

        expect(result).to eq(number_of_subscribers: 1, subscriber: 'Inoreader')
      end
    end

    context 'when there is no subscription count or matching subscriber name' do
      it 'returns 1 and a the ip address' do
        request = double(
          :request,
          ip: '12.34.56.78',
          user_agent: 'Rails Testing'
        )

        result = SubscriptionParser.perform(request)

        expect(result).to eq(
          number_of_subscribers: 1,
          subscriber: '12.34.56.78'
        )
      end
    end
  end
end
