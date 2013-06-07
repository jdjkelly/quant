source 'https://rubygems.org'

gem 'rails', '3.2.12'
gem 'pg'
gem 'pry'
gem 'annotate', ">=2.5.0"
gem 'rails_config'
gem 'oauth'
gem 'devise'
gem 'omniauth'
gem 'omniauth-withings', github: 'jdjkelly/omniauth-withings'
gem 'omniauth-fitbit'
gem 'withings', github: 'jdjkelly/withings'
gem 'fitgem'

group :development do
  gem 'rspec-rails'
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-bundler'
  gem 'foreman'
  gem 'coveralls', require: false
  gem 'quiet_assets'
end

group :test do
  gem 'capybara', '~> 1.1.4'
  gem 'rspec'
  gem 'growl'
  gem 'rb-fsevent'
  gem 'spork-rails'
  gem 'guard-spork'
  gem 'shoulda-matchers'
  gem 'fabrication'
  gem 'database_cleaner'
  gem 'email_spec'
  gem 'faker'
end

group :production do
  gem 'newrelic_rpm'
end

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'compass-rails'
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
  gem 'zurb-foundation', github: 'zurb/foundation'
  gem 'turbolinks'
  gem 'jquery-turbolinks'
  gem 'jquery-rails'
  gem 'd3_rails'
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
