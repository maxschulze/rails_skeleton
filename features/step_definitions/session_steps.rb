Given /^A user who is not logged in$/ do
  visit destroy_user_session_path
end

# implementation
Given /^I am logged in as @(\w+)$/ do |username|
  user = User.find_by_login(username) || Factory(:user, :login => username)
  visit "/login/#{username}"
  @current_user = user
end
