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
