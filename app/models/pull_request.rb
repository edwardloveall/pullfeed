class PullRequest
  include ActiveModel::Model

  attr_accessor :author,
                :created_at,
                :description,
                :link,
                :title

  def guid
    link
  end
end
