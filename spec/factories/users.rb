FactoryBot.define do
  factory :user do
    sequence(:name) { |n| "User #{n}" }
    sequence(:email) { |n| "user#{n}@gmail.com" }
    password { '123123123' }
    profile { 'common' }
  end
end
