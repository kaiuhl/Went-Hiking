class PhotosController < ApplicationController
	def create
		@hike = Hike.find(params[:hike_id])
		@user = @hike.user
		redirect_to :back if @user.id != current_user.id
		
		@photo = @hike.photos.build(params[:photo])
		if @photo.save
			redirect_to :back, :notice => "Added photo."
		else
			render :file => "hikes/show", :layout => "application"
		end
	end
	def destroy
		@photo = Photo.find(params[:id])
		if @photo.hike.user.id != current_user.id
			redirect_to :back
		else
			@photo.destroy
			redirect_to :back, :notice => "Deleted photo."
		end
		
	end
end
