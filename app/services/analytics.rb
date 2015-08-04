module Analytics
  def requested_feed(owner:, repo:)
    KeenAnalytics.requested_feed(owner: owner, repo: repo)
    MixpanelAnalytics.requested_feed(owner: owner, repo: repo, request: request)
  end
end
