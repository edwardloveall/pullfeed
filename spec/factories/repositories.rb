FactoryGirl.define do
  factory :repository do
    created_at { DateTime.current.to_s }
    description 'this fixed that one bug that has been annoying us for a while'
    link 'http://github.com/foo/bar/pulls/1'
    title 'Fix that one bug'
  end
end
