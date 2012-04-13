class UserSessionsController < ApplicationController
  def new
    @user_session = UserSession.new
		render :layout => "small"
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "You are now logged in."
			if request.fullpath != "/user_sessions"
     		redirect_to :back rescue redirect_to root_path
			else
				redirect_to params[:whence] rescue redirect_to root_path
			end
    else
			@whence = request.referer
      render :action => 'new', :layout => "small"
    end
  end

  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "You are now logged out."
    redirect_to :back rescue redirect_to root_path
  end
end