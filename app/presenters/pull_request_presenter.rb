require 'active_support/core_ext/module/delegation'

class PullRequestPresenter
  attr_reader :pull_request

  delegate :author,
           :created_at,
           :description,
           :link,
           :title,
           to: :@pull_request

  def initialize(pull_request)
    @pull_request = pull_request
  end

  def html_description
    MarkdownRenderer.new(@pull_request.description).to_html
  end

  def tag_uri
    unchanging_hostname = 'pullfeed.co'
    date = created_at.to_date.to_s
    path = URI(link).path

    "tag:#{unchanging_hostname},#{date}:#{path}"
  end
end
