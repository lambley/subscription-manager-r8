FactoryBot.define do
  factory :subscription do
    user { nil }
    name { "MyString" }
    price { "9.99" }
    billing_frequency { "monthly" }
    started_at { "2025-01-01 10:23:38" }
    expires_at { "2025-05-01 10:23:38" }
  end
end
