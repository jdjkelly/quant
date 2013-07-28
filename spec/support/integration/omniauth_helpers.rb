module Integration
  module OmniauthHelpers
    OmniAuth.config.mock_auth[:withings] = OmniAuth::AuthHash.new({
      provider: "withings",
      uid: "0",
      userid: "0",
      info: {
        name: nil
      },
      credentials: {
        token: "0",
        secret: "0"
      }
    })

    OmniAuth.config.mock_auth[:fitbit] = OmniAuth::AuthHash.new({
      provider: "fitbit",
      uid: "0",
      info: {
        full_name: "Test User",
        display_name: "Test",
        nickname: "testuser",
        gender: "MALE",
        about_me: nil,
        city: "0",
        state: nil,
        country: "0",
        dob: "Mon, 01 Jan 1970",
        member_since: "Mon, 01 Jan 1970",
        locale: "en_US",
        timezone: "America/New_York",
        name: "testuser"
      },
      credentials: {
        token: "0",
        secret: "0"
      }
    })
  end
end
