# delete_database method deletes all records from the User and Subscription tables if env variable set
def delete_database
  puts "Deleting database..."
  User.destroy_all
  Subscription.destroy_all
end

if ENV['DELETE_DEV_DATABASE'] == 'true'
  delete_database
end

puts "Seeding database..."
# create 2 test users
user1 = User.create!(email_address: 'user@user.com', password: 'password', first_name: 'User', last_name: 'One', locale: 'gb', budget: 100)

user2 = User.create!(email_address: 'test@test.com', password: 'password', first_name: 'Test', last_name: 'User', locale: 'us', budget: 200)

puts "#{User.count} users created"

# create 2 test subscriptions per user
user1.subscriptions.create!(name: 'netflix', price: "9.99", billing_frequency: 'monthly', started_at: Time.current - 1.month, expires_at: Time.current + 1.month)
user1.subscriptions.create!(name: 'amazon_prime_video', price: "19.99", billing_frequency: 'monthly', started_at: Time.current - 2.months, expires_at: Time.current - 1.month)

user2.subscriptions.create!(name: 'disney_plus', price: "29.99", billing_frequency: 'monthly', started_at: Time.current - 1.month, expires_at: Time.current + 1.month)
user2.subscriptions.create!(name: 'hbo_max', price: "39.99", billing_frequency: 'monthly', started_at: Time.current - 2.months, expires_at: Time.current - 1.month)

puts "#{Subscription.count} subscriptions created"
