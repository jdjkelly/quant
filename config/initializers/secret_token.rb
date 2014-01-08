if Rails.env.test? || Rails.env.development? || Rails.env == "profile"
  Quantify::Application.config.secret_token = "8ae1beeb1dbcda5851624d6dbf1c6656827e54d81c025501a7a23e09801ec2eee0f05625218ec45479bb28eb23c60fd73a89ae0e3e6cf5fbce0c2c13da6fd89b"
  Quantify::Application.config.secret_key_base = "c6e66601cd5d4b6183ac99d88421f303b8bda479dfc6f8bcb5a89c6ed7c54bf62ee26ba9c49de98608d0209549ba1e666ed87dcf0ec988146af628efc13e7c2f"
else
  raise "You must set a secret token in ENV['SECRET_TOKEN'] or in config/initializers/secret_token.rb" if !Settings.secret_token
  Quantify::Application.config.secret_token = Settings.secret_token
  Quantify::Application.config.secret_key_base = Settings.secret_key_base
end
