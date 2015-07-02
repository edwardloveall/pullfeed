class PullRequest
  include ActiveModel::Model

  attr_accessor :author,
                :created_at,
                :description,
                :link,
                :title

  def created_at=(created_at)
    @created_at = DateTime.parse(created_at)
  end

  def guid
    link
  end
end
