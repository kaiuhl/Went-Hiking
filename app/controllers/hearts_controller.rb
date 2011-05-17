class HeartsController < ApplicationController
	before_filter :authorize
  def create
		if current_user.id != params[:current_user]
			@heart = Heart.find_or_create_by_user_id_and_hike_id(:user_id => current_user.id, :hike_id => params[:hike_id])
			@hike = @heart.hike
		else
			render "nope"
		end
  end

  def destroy
		@heart = Heart.find_by_user_id_and_hike_id(current_user.id, params[:hike_id])
		@hike = @heart.hike
		@heart.destroy
  end
end
