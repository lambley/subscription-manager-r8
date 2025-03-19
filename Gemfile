source "https://rubygems.org"

# Rails and Core Dependencies
gem "rails", "~> 8.0.1"
gem "pg"
gem "puma", ">= 5.0"

# Asset Management
gem "propshaft"
gem "importmap-rails"
gem "turbo-rails"
gem "stimulus-rails"
gem "tailwindcss-rails", "~> 4.2"

# Graphing and Data Visualization
gem "chartkick"

# Authentication and Security
gem "bcrypt", "~> 3.1.7"

# Utilities
gem "jbuilder"
gem "tzinfo-data", platforms: %i[ windows jruby ]

# Solid Gems (currently not used)
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# Optional Gems
gem "bootsnap", require: false
gem "kamal", require: false
gem "thruster", require: false

group :development, :test do
  # Debugging and Environment Management
  gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
  gem "dotenv-rails", groups: [ :development, :test ]

  # Code Quality and Testing
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false
  gem "rspec-rails", "~> 7.1.0"
  gem "factory_bot_rails"
  gem "simplecov", require: false
  gem "faker"
  gem "database_cleaner"
  gem "rails-controller-testing"
end

group :development do
  gem "web-console"
end
