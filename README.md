# How to create users

In `rails console`:

```ruby
User.create!(email_address: "user@user.com", password: "1234", first_name: "user", last_name: "name")
```

# How to create Subscriptions data

In `rails console`:

```ruby
Subscription.create!(user: User.last, name: "test subscription", price: "9.99", billing_frequency: "monthly", started_at: "2025-01-01 00:00:00", expires_at: "2025-02-01 00:00:00")
```
