RSpec.configure do |config|
  config.include Integration::ActionMailerHelpers, :type => :request
end
