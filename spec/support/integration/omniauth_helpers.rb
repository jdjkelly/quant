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

  OmniAuth.config.mock_auth[:foursquare] = OmniAuth::AuthHash.new({
    provider: "foursquare",
    uid: "152588",
    info: {
      first_name: "Test",
      last_name: "User",
      email: "test@example.com",
      image: {
        prefix: "https://irs3.4sqi.net/img/user/",
        suffix: "/-IK3N0AMMIZ20ZS3H.jpg"
      },
      location: "Toronto, Canada"
    },
    credentials: {
      token: "0",
      expires: "false"
    },
    extra: {
      raw_info: {
        createdAt: 1391817305
      }
    }
  })

end
