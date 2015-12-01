module Analytics
  def requested_feed(owner:, repo:)
    if ENV.fetch('KEEN_WRITE_KEY')
      KeenAnalytics.requested_feed(owner: owner, repo: repo)
    end
  end
end
