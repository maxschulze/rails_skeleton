class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'
  
  around_filter :rescue_access_denied

  before_filter :set_user
  before_filter :set_locale
  
  helper :all

private

  def authenticate_user!
    if Rails.env != 'test'
      super
    end
  end
  
  # If the params[:locale] is set it will be used as the first priority
  # If the locale is not forced either the HTTP header locale will be used
  # or the +I18n.default_locale+
  def set_locale 
    # if params[:locale] is nil then I18n.default_locale will be used  
    I18n.locale = 'en'
    
    # if params[:locale].present? || session[:locale].present?
    #   session[:locale] = params[:locale] if params[:locale].present?
    #   I18n.locale = session[:locale]
    # else
    #   logger.debug "* Accept-Language: #{request.env['HTTP_ACCEPT_LANGUAGE']}"  
    #   I18n.locale = extract_locale_from_accept_language_header 
    #   logger.debug "* Locale set to '#{I18n.locale}'"
    # end
  end 
  
  # extracts the locale from the HTTP header to determine the user's prefered language
  def extract_locale_from_accept_language_header 
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first 
  end 
  
  # set the User.current constant for accessing the current user
  # outside controllers and views
  def set_user
    begin
      if user_signed_in?
        User.send :class_variable_set, :@@current, current_user
      end
    rescue Exception => exception
      logger.error "Could not set User.current. Error was #{exception.to_s}"
    end
  end

  # Rescue if a user
  def rescue_access_denied
    yield
  rescue Aegis::AccessDenied => e 
    render :text => e.message, :status => :forbidden
  end
  
end
