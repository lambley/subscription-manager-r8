FactoryBot.define do
  factory :user do
    email_address { 'test@test.com' }
    password { 'password' }
    first_name { 'Test' }
    last_name { 'User' }
  end
end
