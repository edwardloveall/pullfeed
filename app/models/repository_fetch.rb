class RepositoryFetch < ActiveRecord::Base
  validates :owner, presence: true
  validates :repo, presence: true
end
