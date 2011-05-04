module ControllerMacros
  
  def login_user
    before(:each) do
      @user = Factory(:user) # Using blueprints gem for fixtures data
      @request.env["devise.mapping"] = Devise.mappings[:user]
      sign_in @user
    end
  end
  
end