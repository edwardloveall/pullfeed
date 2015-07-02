class Repository
  include ActiveModel::Model
  attr_accessor :created_at,
                :description,
                :link,
                :owner,
                :pull_requests,
                :title

  def language
    'en-us'
  end
end
