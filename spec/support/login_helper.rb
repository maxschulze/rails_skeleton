module LoginHelper
  
  def login
    @user = Factory(:user)
    
    visit new_user_session_path
    
    fill_in 'user_email', :with => @user.email
    fill_in 'user_password', :with => 'secret'
    
    click_button 'user_submit'
    
    return page
  end
  
end