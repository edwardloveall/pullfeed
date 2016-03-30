class Subscription < ActiveRecord::Base
  validates :number_of_subscribers, presence: true
  validates :repository, presence: true
  validates :subscriber, presence: true
end
