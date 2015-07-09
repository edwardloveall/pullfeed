class RepositorySerializer
  def initialize(data)
    @data = data
  end

  def self.perform(data)
    new(data).perform
  end

  def perform
    Repository.new(repository_attributes)
  end

  private

  attr_reader :data

  def parsed_data
    if data.is_a?(Array)
      { repository: data.first['base']['repo'], pull_requests: data }
    else
      { repository: data, pull_requests: [] }
    end
  end

  def repository_data
    @_repository_data = parsed_data[:repository]
  end

  def pull_requests_data
    @_pull_requests_data = parsed_data[:pull_requests]
  end

  def repository_attributes
    {
      created_at: created_at,
      description: repository_data['description'],
      link: repository_data['html_url'],
      owner: repository_data['owner']['login'],
      pull_requests: pull_requests,
      title: repository_data['name']
    }
  end

  def pull_requests
    pull_requests_data.map do |pull_request|
      PullRequestSerializer.perform(pull_request)
    end
  end

  def created_at
    if !pull_requests_data.empty?
      DateTime.parse(pull_requests_data.first['created_at'])
    else
      DateTime.parse(repository_data['created_at'])
    end
  end
end
