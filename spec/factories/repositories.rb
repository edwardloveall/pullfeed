FactoryBot.define do
  factory :repository do
    created_at { DateTime.current.to_s }
    description 'this old codebase'
    link 'http://github.com/github/code'
    owner 'github'
    pull_requests { [build(:pull_request), build(:pull_request)] }
    title 'code'
  end
end
