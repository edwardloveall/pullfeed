FactoryGirl.define do
  factory :pull_request do
    created_at { DateTime.current }
    description 'this fixed that one bug that has been annoying us for a while'
    link 'http://github.com/github/code/pulls/1'
    title 'Fix that one bug'
  end
end
