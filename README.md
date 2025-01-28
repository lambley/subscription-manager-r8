# Local Development

## Rails Server

- Setup the database: `rails db:setup`
- Seed the database: `rails db:seed` (optional)
- Start the server: `rails s`
- Start developing - runs locally on `http://localhost:3000`

## Docker-Compose

- Build and start the image: `docker-compose up build`
- Setup database: `docker-compose run web bundle exec rails db:setup` (optional)
- Seed the database: `docker-compose run web bundle exec rails db:seed` (optional)
- Start developing - runs locally on `http://localhost:3000`

# TODO

- Implement these components: https://www.neobrutalism.dev/docs
- Fix flash notices - they should not push elements down, should appear over other components, and disappear on click and after 3 seconds
