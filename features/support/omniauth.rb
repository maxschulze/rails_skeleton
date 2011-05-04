TwitterUID = "820498230498712378219737"

Before('@omniauth_test') do
  OmniAuth.config.test_mode = true

  OmniAuth.config.mock_auth[:twitter] = {
      "provider"=>"twitter",
      "uid"=>TwitterUID,
      "user_info"=>{}
  }
end

After('@omniauth_test') do
  OmniAuth.config.test_mode = false
end