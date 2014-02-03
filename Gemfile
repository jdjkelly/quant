source 'https://rubygems.org'
source 'https://rails-assets.org'

ruby "2.1.0"

gem 'rails', '4.0.0'
gem 'rails_config'

# Rails 4.1 upgrade to remove
gem 'active_model_serializers'
gem 'protected_attributes'
gem 'concerning', github: '37signals/concerning'

# Databases
gem 'activerecord-postgres-hstore'
gem 'activerecord-postgres-earthdistance'
gem 'annotate', '>=2.5.0'
gem 'pg'

# Authentication & APIs
gem 'cancan'
gem 'oauth'
gem 'devise', github: 'plataformatec/devise'
gem 'omniauth'
gem 'omniauth-withings', github: 'jdjkelly/omniauth-withings'
gem 'omniauth-fitbit'
gem 'omniauth-foursquare'
gem 'withings', github: 'jdjkelly/withings'
gem 'fitgem', github: 'whazzmaster/fitgem' # Version 0.9 wasn't out yet - once it is, we can revert back to rubygems source

# Assets
gem 'sass-rails',   '~> 4.0.0'
gem 'compass-rails', '~> 1.1.3'
gem 'coffee-rails'
gem 'uglifier', '>= 1.0.3'
gem 'foundation-rails', github: 'mattmueller/foundation-rails'
gem 'turbolinks'
gem 'jquery-turbolinks'
gem 'jquery-rails'
gem 'd3-rails'
gem 'rails-assets-cal-heatmap', '3.3.9'
gem 'font-awesome-rails'

group :development do
  gem 'rspec-rails'
  gem 'guard',            require: false
  gem 'guard-rspec',      require: false
  gem 'guard-bundler',    require: false
  gem 'foreman'
  gem 'quiet_assets'
  gem 'pry-rails'
  gem 'thin'
  gem 'ruby_gntp'
  gem 'guard-livereload', require: false
  gem 'rack-livereload'
  gem 'parallel_tests'
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
  gem 'fuubar'
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
