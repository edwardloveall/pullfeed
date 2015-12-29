module Analytics
  def requested_feed(owner:, repo:)
    if ENV['KEEN_WRITE_KEY'].present?
      KeenAnalytics.requested_feed(owner: owner, repo: repo)
    end
  end
end
