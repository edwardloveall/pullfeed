module MixpanelAnalytics
  def requested_feed(owner:, repo:)
    event = 'Fetched feed'
    properties = { owner: owner, repo: repo }
    track(event, properties)
  end

  private

  def track(event, properties)
    tracker.track(user_id, event, properties)
  end

  def tracker
    @tracker ||= Mixpanel::Tracker.new(ENV['MIXPANEL_TOKEN'])
  end

  def user_id
    request.remote_ip
  end
end
