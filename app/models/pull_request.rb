class PullRequest
  include ActiveModel::Model

  attr_accessor :title,
                :link,
                :description,
                :created_at

  def created_at=(created_at)
    @created_at = DateTime.parse(created_at)
  end
end
