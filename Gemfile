source 'https://rubygems.org'
ruby "2.0.0"

gem 'rails', '4.0.0'
gem 'rails_config'
gem 'oauth'
gem 'devise', github: 'plataformatec/devise'
gem 'omniauth'
gem 'omniauth-withings', github: 'jdjkelly/omniauth-withings'
gem 'omniauth-fitbit'
gem 'withings', github: 'jdjkelly/withings'
gem 'fitgem'
gem 'activerecord-postgres-hstore'
gem 'activerecord-postgres-earthdistance'
gem 'annotate', '>=2.5.0'
gem 'active_model_serializers'
gem 'pg'
gem 'protected_attributes'
gem 'cancan'

# Assets
gem 'sass-rails',   '~> 4.0.0'
gem 'compass-rails', '~> 1.1.3'
gem 'coffee-rails'
gem 'uglifier', '>= 1.0.3'
gem 'foundation-rails', github: 'zurb/foundation-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'jquery-rails'

group :development do
  gem 'rspec-rails'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'foreman'
  gem 'quiet_assets'
  gem 'pry-rails'
  gem 'thin'
end

group :test do
  gem 'capybara', '~> 1.1.4'
  gem 'rspec'
  gem 'growl'
  gem 'rb-fsevent'
  gem 'spork-rails', github: 'sporkrb/spork-rails', ref: '3224f84d8c31fcb0894e9a43f6c3ac67e3aa0d71'
  gem 'guard-spork'
  gem 'shoulda-matchers'
  gem 'fabrication'
  gem 'database_cleaner'
  gem 'faker'
  gem 'email_spec'
  gem 'webmock'
end

group :production do
  gem 'newrelic_rpm'
  gem 'rails_12factor' # Heroku requires this
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'debugger'
