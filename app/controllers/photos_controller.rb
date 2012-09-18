class PhotosController < ApplicationController
  def index
    @trip = Trip.find(params[:trip_id])
    @photos = @trip.photos
  end
  def create
    @trip = Trip.find(params[:trip_id])
    @user = @trip.user
    redirect_to :back if @user.id != current_user.id

    @photo = @trip.photos.build(params[:photo])
    if @photo.save
      redirect_to user_trip_path(@user, @trip), :notice => "Added photo."
    else
      flash[:error] = @photo.errors.full_messages.to_s
      redirect_to user_trip_path(@user, @trip)
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
