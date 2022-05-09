class PullRequestFetcher
  GITHUB_BASE_URL = 'https://api.github.com'.freeze

  def initialize(owner:, repo:, q:)
    @owner = owner
    @repo = repo
    @q = q
  end

  def self.perform(owner:, repo:, q:)
    new(owner: owner, repo: repo, q: q).perform
  end

  def perform
    if q.nil?
      prs = response
      repository =
        if prs.empty?
          repository_response
        else
          prs.first['base']['repo']
        end
    else
      prs = search_response['items']
      repository = repository_response
    end
    { repository: repository, pull_requests: prs }
  end

  private

  attr_reader :owner, :repo, :q

  def repo_path
    "#{GITHUB_BASE_URL}/repos/#{owner}/#{repo}"
  end

  def repo_pulls_path
    "#{GITHUB_BASE_URL}/repos/#{owner}/#{repo}/pulls"
  end

  def search_url
    query = {
      q: "repo:#{owner}/#{repo} is:pr is:open #{q}",
      sort: 'created',
      per_page: 100
    }
    "#{GITHUB_BASE_URL}/search/issues?#{query.to_query}"
  end

  def response
    res = HTTParty.get(repo_pulls_path, headers: headers)
    if res.code == 404
      raise RepositoryNotFound
    elsif res.empty?
      res
    else
      res.parsed_response
    end
  end

  def repository_response
    res = HTTParty.get(repo_path, headers: headers)
    if res.code == 404
      raise RepositoryNotFound
    end
    res.parsed_response
  end

  def search_response
    HTTParty.get(search_url, headers: headers).parsed_response
  end

  def headers
    { 'Authorization' => "token #{ENV['GITHUB_ACCESS_TOKEN']}",
      'User-Agent' => ENV['GITHUB_USERNAME'] }
  end

  class RepositoryNotFound < StandardError
  end
end
