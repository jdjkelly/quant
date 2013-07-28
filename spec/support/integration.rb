RSpec.configure do |config|
  config.include Integration::ActionMailerHelpers, :type => :request
  config.include Integration::OmniauthHelpers, :type => :request
end
