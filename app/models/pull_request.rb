class PullRequest
  include ActiveModel::Model

  attr_accessor :author,
                :created_at,
                :description,
                :link,
                :title
end
