class SubscriptionParser
  def self.perform(request)
    new(request).perform
  end

  def initialize(request)
    @request = request
    @user_agent = request.user_agent || ''
  end

  def perform
    subscriber = subscriber_name || ip_address
    { number_of_subscribers: number_of_subscribers, subscriber: subscriber }
  end

  private

  attr_accessor :request, :user_agent

  def number_of_subscribers
    regex = /(\d*)\s*(subscriber|reader)/
    matches = user_agent.match(regex)
    if matches && matches[1].present?
      matches[1].to_i
    else
      1
    end
  end

  def ip_address
    request.ip
  end

  def subscriber_name
    subscriber_list.each_pair do |pattern, name|
      if user_agent.include?(pattern)
        return name
      end
    end

    nil
  end

  def subscriber_list
    {
      'NewsBlur' => 'NewsBlur',
      'Feedly' => 'Feedly',
      'Feed Wrangler' => 'Feed Wrangler',
      'Fever' => 'Fever',
      'AolReader' => 'AOL Reader',
      'FeedHQ' => 'FeedHQ',
      'BulletinFetcher' => 'Bulletin',
      'Digg' => 'Digg',
      'Bloglovin' => 'Bloglovin',
      'inoreader.com' => 'Inoreader',
      'Xianguo' => 'Xianguo',
      'HanRSS' => 'HanRSS',
      'FeedBlitz' => 'FeedBlitz',
      'Feedshow' => 'Feedshow',
      'FeedSync' => 'FeedSync',
      'Slickreader Feed Fetcher' => 'Slickreader',
      'NetNewsWire' => 'NetNewsWire',
      'NewsGatorOnline' => 'NewsGator',
      'FeedDemon' => 'FeedDemon',
      'Netvibes' => 'Netvibes',
      'livedoor FeedFetcher' => 'livedoor',
      'Superfeedr' => 'Superfeedr',
      'g2reader-bot' => 'g2reader',
      'Feedbin' => 'Feedbin',
      'CurataRSS' => 'CurataRSS',
      'Reeder' => 'Reeder',
      'Sleipnir' => 'Sleipnir',
      'BlogshelfII' => 'BlogshelfII',
      'Caffeinated' => 'Caffeinated',
      'RSSOwl' => 'RSSOwl',
      'NewsFire' => 'NewsFire',
      'NewsLife' => 'NewsLife',
      'Vienna' => 'Vienna',
      'Lector' => 'Lector',
      'Sylfeed' => 'Sylfeed',
      'curl' => 'curl',
      'Wget' => 'wget',
      'rss2email' => 'rss2email',
      'Python-urllib' => 'Python',
      'feedzirra' => 'feedzira',
      'newsbeuter' => 'newsbeuter',
      'Leselys' => 'Leselys',
      'Java' => 'Java',
      'Jakarta' => 'Java',
      'Apache-HttpClient' => 'Java',
      'Ruby' => 'Ruby',
      'PHP' => 'PHP',
      'Zend' => 'PHP',
      'Leaf' => 'Leaf',
      'lire' => 'lire',
      'SimplePie' => 'SimplePie',
      'ReadKit' => 'ReadKit',
      'NewsRack' => 'NewsRack',
      'Bloglines' => 'Bloglines',
      'Pulp' => 'Pulp',
      'Liferea' => 'Liferea',
      'TBRSS' => 'TBRSS',
      'SushiReader' => 'SushiReader',
      'Akregator' => 'Akregator',
      'Sage' => 'Sage',
      'Tiny Tiny RSS' => 'Tiny Tiny RSS',
      'FreeRSSReader' => 'FreeRSSReader',
      'Yahoo Pipes' => 'Yahoo Pipes',
      'WordPress' => 'WordPress',
      'FeedBurner' => 'FeedBurner',
      'Dreamwith Studios' => 'Dreamwith Studios',
      'LiveJournal' => 'LiveJournal',
      'Apple-PubSub' => 'Apple PubSub',
      'Multiplexer.me' => 'Multiplexer.me',
      'Microsoft Office' => 'Microsoft Office',
      'Windows-RSS-Platform' => 'Windows RSS',
      'FriendFeedBot' => 'FriendFeed',
      'Yahoo! Slurp' => 'Yahoo! Slurp',
      'YahooFeedSeekerJp' => 'YahooFeedSeekerJp',
      'YoudaoFeedFetcher' => 'Youdao',
      'PushBot' => 'PushBot',
      'FeedBooster' => 'FeedBooster',
      'Squider' => 'Squider',
      'Downcast' => 'Downcast',
      'Instapaper' => 'Instapaper',
      'Thunderbird' => 'Mozilla Thunderbird',
      'Flipboard' => 'Flipboard',
      'Genieo' => 'Genieo',
      'Hivemined' => 'Hivemined',
      'theoldreader.com' => 'The Old Reader',
      'AppEngine-Googleappid' => 'Google App Engine',
      'Googlebot' => 'Googlebot',
      'UniversalFeedParser' => 'UniversalFeedParser',
      'Opera' => 'Opera'
    }
  end
end
