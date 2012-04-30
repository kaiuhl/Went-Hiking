class HeartsController < ApplicationController
	before_filter :authorize
  def create
		@trip = Trip.find(params[:trip_id])
		if current_user.id != @trip.user.id
			@heart = Heart.find_or_create_by_user_id_and_trip_id(:user_id => current_user.id, :trip_id => params[:trip_id])
			@hearts = @trip.hearts
		else
			render "nope"
		end
  end

  def destroy
		@heart = Heart.find_by_user_id_and_trip_id(current_user.id, params[:trip_id])
		@trip = @heart.trip
		@hearts = @trip.hearts
		@heart.destroy
  end
end
