class PrFetcher
  attr_reader :owner, :repo
  GITHUB_BASE_URL = 'https://api.github.com'

  def initialize(owner:, repo:)
    @owner = owner
    @repo = repo
  end

  def self.perform(owner:, repo:)
    new(owner: owner, repo: repo).perform
  end

  def perform
    HTTParty.get(repo_path)
  end

  private

  def repo_path
    "#{GITHUB_BASE_URL}/repos/#{owner}/#{repo}/pulls"
  end
end
