class HeartsController < ApplicationController
  def create
		@heart = Heart.create(:user_id => params[:user_id], :hike_id => params[:hike_id])
  end

  def destroy
		@heart = Heart.find(:user_id => params[:user_id], :hike_id => params[:hike_id])
		@heart.destroy
  end
end
