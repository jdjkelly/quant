require "#{Rails.root}/spec/support/integration/action_mailer_helpers.rb"
require "#{Rails.root}/spec/support/integration/omniauth_helpers.rb"

RSpec.configure do |config|
  config.include Integration::ActionMailerHelpers, type: :request
  config.include Integration::OmniauthHelpers, type: :request
end
