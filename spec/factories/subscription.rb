FactoryBot.define do
  factory :subscription do
    association :user
    name { "MyString" }
    price { "9.99" }
    billing_frequency { "monthly" }
    started_at { Time.current - 1.month }
    expires_at { Time.current + 1.month }
  end
end
