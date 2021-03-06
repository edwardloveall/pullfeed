class RepositoryFetcher
  GITHUB_BASE_URL = 'https://api.github.com'.freeze

  def initialize(owner:, repo:)
    @owner = owner
    @repo = repo
  end

  def self.perform(owner:, repo:)
    new(owner: owner, repo: repo).perform
  end

  def perform
    response.parsed_response
  end

  private

  attr_reader :owner, :repo

  def repo_path
    "#{GITHUB_BASE_URL}/repos/#{owner}/#{repo}"
  end

  def response
    @_response ||= HTTParty.get(repo_path, headers: headers)
  end

  def headers
    { 'Authorization' => "token #{ENV['GITHUB_ACCESS_TOKEN']}",
      'User-Agent' => ENV['GITHUB_USERNAME'] }
  end
end
