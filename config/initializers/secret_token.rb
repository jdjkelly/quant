if Rails.env.test? || Rails.env.development? || Rails.env == "profile"
  Bodyimage::Application.config.secret_token = "47f5390004bf6d25bb97083fb98e7cc133ab450ba814dd19638a78282b4ca291"
else
  raise "You must set a secret token in ENV['SECRET_TOKEN'] or in config/initializers/secret_token.rb" if Settings.secret_token
  Bodyimage::Application.config.secret_token = Settings.secret_token
end
