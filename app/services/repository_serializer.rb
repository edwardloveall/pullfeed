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

  def repository_attributes
    {
      created_at: created_at,
      description: base_attributes['description'],
      link: base_attributes['html_url'],
      owner: base_attributes['owner']['login'],
      pull_requests: pull_requests,
      title: base_attributes['name']
    }
  end

  def base_attributes
    @_base_attributes ||= data.first['base']['repo']
  end

  def pull_requests
    @data.map do |pull_request_data|
      PullRequestSerializer.perform(pull_request_data)
    end
  end

  def created_at
    DateTime.parse(data.first['created_at'])
  end
end
