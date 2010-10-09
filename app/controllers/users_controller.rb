class UsersController < InheritedResources::Base
  respond_to :html, :json, :xml
  before_filter :authenticate_user!, :except => [:backdoor]

  def backdoor
    logout_killing_session!
    warden.set_user User.where(:login => params[:username]).first

    logger.info "#{User.where(:login => params[:username]).first.inspect}"
    logger.info "Setting user #{params[:username]}".red
    logger.info "Current user is now #{current_user}".red

    head :ok
  end

  def edit
    @user = current_user
  end

private

  def logout_killing_session!
    warden.logout
    warden.reset_session!
  end

end