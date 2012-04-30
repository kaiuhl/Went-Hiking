class NotificationsController < ApplicationController
	def index
    @notifications = current_user.notifications
	end
	def create
		@notification = Notification.new(params[:notification])
		if @notification.save
			redirect_to :back, :notice => "Added Notification successfully."
		else
			render :new
		end
	end
	def destroy
		@notification = Notification.find(params[:id])
		@notification.destroy
		redirect_to :back, :notice => "Deleted succesfully."
	end
  def read
    @notification = Notification.find(params[:id])
    if @notification && @notification.read_at == nil
      @notification.read_at = Time.now
      @notification.save
    end
    @count = current_user.notifications.unread.size
  end
end
