module Analytics
  def requested_feed(owner:, repo:)
    KeenAnalytics.requested_feed(owner: owner, repo: repo)
  end
end
