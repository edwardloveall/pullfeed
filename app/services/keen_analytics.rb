class KeenAnalytics
  def self.requested_feed(owner:, repo:)
    new.requested_feed(owner: owner, repo: repo)
  end

  def requested_feed(owner:, repo:)
    event = 'Fetched feed'
    properties = { owner: owner, repo: repo }
    Keen.publish(event, properties)
  end
end
