FactoryBot.define do
  factory :assessment do
    rating { 5 }
    comment { "MyString" }
    place { nil }
    user { nil }
  end
end
