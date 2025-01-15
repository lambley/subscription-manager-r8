FactoryBot.define do
  factory :user do
    email_address { 'test@test.com' }
    password { 'password' }
    first_name { 'Test' }
    last_name { 'User' }
    locale { 'us' }
  end

  trait :gb do
    locale { "gb" }
  end

  trait :us do
    locale { "us" }
  end
end
