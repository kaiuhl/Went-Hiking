class UsersController < ApplicationController
  before_filter :current_user, :only => [:edit, :update]
  before_filter :admin?, :only => [:new, :create, :destroy]
	layout "small"
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
	render :layout => "small"
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "#{@user.name} successfully added and emailed."
      WebsiteMailer.deliver_welcome_email(params[:user][:password], @user, current_user)
      redirect_to user_hikes_path(@user)
    else
      render :action => 'new', :layout => "small"
    end
  end
  
  def edit
    @user = current_user
  end
  
  def update
    @user = current_user
    if @user.update_attributes(params[:user])
      flash[:notice] = "Successfully updated profile."
      redirect_to edit_user_path(@user)
    else
      render :action => 'edit'
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    if @user.destroy
      flash[:notice] = "Successfully deleted."
      redirect_to users_path
    else
      render :action => 'index'
    end
  end
  
  def password
	render :layout  => "small"
  end
  
  def reset_password
    @user = User.find_by_email(params[:email]) 
    if @user     
      if @user.reset_password!
        WebsiteMailer.deliver_reset_password(@user)
        flash[:notice] = "We've just sent you a new password! Check your email."
        redirect_to login_path
      else
        flash[:notice] = @user.errors.methods.join "<br />"
        redirect_to reset_password_path
      end
    else 
      flash[:error] = "You're not on the books or not authorized to log in. Did you type in your email address correctly?"
      redirect_to reset_password_path
    end
  end
end