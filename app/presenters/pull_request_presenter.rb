require 'active_support/core_ext/module/delegation'

class PullRequestPresenter
  delegate :created_at,
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
end
