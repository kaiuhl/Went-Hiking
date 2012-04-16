class PhotosController < ApplicationController
	def index
		@photos = Photo.all
	end
	def create
		@trip = Trip.find(params[:hike_id])
		@user = @trip.user
		redirect_to :back if @user.id != current_user.id
		
		@photo = @trip.photos.build(params[:photo])
		if @photo.save
			redirect_to user_hike_path(@user, @trip), :notice => "Added photo."
		else
			render :file => "trips/show", :layout => "application"
		end
	end
	def destroy
		@photo = Photo.find(params[:id])
		if @photo.trip.user.id != current_user.id
			redirect_to :back
		else
			@photo.destroy
			redirect_to :back, :notice => "Deleted photo."
		end
	end
end
