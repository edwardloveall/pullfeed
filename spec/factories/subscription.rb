FactoryBot.define do
  factory :subscription do
    number_of_subscribers 1
    repository 'github/code'
    subscriber 'Feedbin'
  end
end
