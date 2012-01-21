class NotificationsController < ApplicationController
	def index
		@notifications = Notification.all
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
end