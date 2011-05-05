class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery
  helper_method :current_user, :personal_current_user, :admin?

  private

	def authorize
		unless current_user
      redirect_to login_path, :error => "You aren't logged in."
    end
	end
	
	def personal_authorize
		if current_user.blank? || !personal_current_user
			flash[:error] = "This doesn't belong to you."
      redirect_to :back rescue redirect_to root_path
    end
	end

  def current_user
    @current_user = UserSession.find.record rescue nil
  end

	def personal_current_user
		current_user.id == params[:user_id].to_i rescue nil
	end
  
  def admin?
    UserSession.find.record.admin rescue nil
  end
end