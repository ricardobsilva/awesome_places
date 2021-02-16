FactoryBot.define do
  factory :place do
    sequence(:name) { |n| "Place #{n}" }
    sequence(:description) { |n| "Awesome bar#{n}" }
    lat { -9.657096 }
    lng { -35.736519 }
  end
end
