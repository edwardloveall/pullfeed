class PullRequestFetcher
  GITHUB_BASE_URL = 'https://api.github.com'.freeze

  def initialize(owner:, repo:)
    @owner = owner
    @repo = repo
  end

  def self.perform(owner:, repo:)
    new(owner: owner, repo: repo).perform
  end

  def perform
    if response.code == 404
      raise RepositoryNotFound
    elsif !response.empty?
      response
    else
      repository_response
    end
  end

  private

  attr_reader :owner, :repo

  def repo_path
    "#{GITHUB_BASE_URL}/repos/#{owner}/#{repo}/pulls"
  end

  def response
    @_response ||= HTTParty.get(repo_path, headers: headers)
  end

  def headers
    { 'Authorization' => "token #{ENV['GITHUB_ACCESS_TOKEN']}",
      'User-Agent' => ENV['GITHUB_USERNAME'] }
  end

  def repository_response
    RepositoryFetcher.perform(owner: owner, repo: repo)
  end

  class RepositoryNotFound < StandardError
  end
end
