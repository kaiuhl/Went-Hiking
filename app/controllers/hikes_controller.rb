class HikesController < ApplicationController
	before_filter :authorize, :except => [:index, :show, :search]
	before_filter :personal_authorize, :only => [:new, :create, :edit, :update, :destroy]
	
	def index
		@year = params[:year].try(:to_i)
		@year ||= DateTime.now.year
		
		@user = User.find(params[:user_id]) unless params[:user_id].blank?
		@user ||= current_user rescue nil
		
		@hikes = @user.hikes.year(@year)
		@other_years_hikes = @user.hikes.map{|h| h.hiked_at.year }.uniq.reject{|h| h == @year}
		
		if @hikes.blank?
			@year = 1.year.ago.year
			@hikes = @user.hikes.year(@year)
		end
	end
	
	def search
		@hikes = Hike.where("name LIKE ? OR report LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%").order("hiked_at DESC, name ASC")
	end
	
	def advanced_search
		@hikes = Hike.all
	end
	
	def show
		@hike = Hike.find(params[:id])
		@user = @hike.user
		@heart = @hike.hearts.find_or_initialize_by_hike_id_and_user_id(@hike.id, current_user.try(:id))
		@comments = @hike.comments
		@hearts = @hike.hearts
		@comment = Comment.new(:hike_id => @hike.id, :user_id => current_user.id) rescue nil
		@nearby_hikes = Hike.within(10, :origin => [@hike.lat,@hike.lng]).order("distance DESC").where("id != ?", @hike.id).limit(10)
		@forecast = Forecast.find_or_create_by_lat_and_lng(@hike.lat, @hike.lng) rescue nil
	end
	def new
		@user = User.find(params[:user_id])
		@hike = Hike.new(:user_id => @user.id, :hiked_at => 1.day.ago)
	end
	def create
		@hike = Hike.new(params[:hike])
		if @hike.save
			redirect_to user_hike_path(@hike.user, @hike), :notice => "Added the hike!"
		else
			render :action => "new"
		end
	end
	def edit
		@hike = Hike.find(params[:id])
		@user = @hike.user
	end
	def update
		@hike = Hike.find(params[:id])
		if @hike.update_attributes(params[:hike])
			redirect_to user_hike_path(@hike.user, @hike), :notice => "Updated the hike."
		else
			render :action => "edit"
		end	
	end
	def destroy
		@hike = Hike.find(params[:id])
		@user = @hike.user
		@hike.destroy
		redirect_to user_hikes_path(@user), :notice => "Deleted that hike, as requested."
	end
end
