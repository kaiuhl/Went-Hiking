class TripsController < ApplicationController
	before_filter :authorize, :except => [:index, :show, :search]
	before_filter :personal_authorize, :only => [:new, :create, :edit, :update, :destroy]
	
	def index
		@year = params[:year].try(:to_i)
		@year ||= DateTime.now.year
		
		@user = User.find(params[:user_id]) unless params[:user_id].blank?
		@user ||= current_user rescue nil
		
		@trips = @user.trips.year(@year)
		@other_years_trips = @user.trips.map{|h| h.hiked_at.year }.uniq.reject{|h| h == @year}
		
		if @trips.blank?
			@year = 1.year.ago.year
			@trips = @user.trips.year(@year)
		end
	end
	
	def search
		@trips = Trip.where("name LIKE ? OR report LIKE ?", "%#{params[:q]}%", "%#{params[:q]}%").order("hiked_at DESC, name ASC")
	end
	
	def advanced_search
		@trips = Trip.all
	end
	
	def show
		@trip = Trip.find(params[:id])
		@user = @trip.user
		@heart = @trip.hearts.find_or_initialize_by_trip_id_and_user_id(@trip.id, current_user.try(:id))
		@comments = @trip.comments
		@hearts = @trip.hearts
		@comment = Comment.new(:trip_id => @trip.id, :user_id => current_user.id) rescue nil
		# @nearby_trips = Trip.within(10, :origin => [@trip.lat,@trip.lng]).order("created_at DESC").where("id != ?", @trip.id).limit(5)
		@forecast = Forecast.find_or_create_by_lat_and_lng(@trip.lat, @trip.lng) rescue nil
	end
	def new
		@user = User.find(params[:user_id])
		@trip = Trip.new(:user_id => @user.id, :hiked_at => 1.day.ago)
	end
	def create
		@trip = Trip.new(params[:trip])
		if @trip.save
			redirect_to user_hike_path(@trip.user, @trip), :notice => "Added the trip!"
		else
			render :action => "new"
		end
	end
	def edit
		@trip = Trip.find(params[:id])
		@user = @trip.user
	end
	def update
		@trip = Trip.find(params[:id])
		if @trip.update_attributes(params[:trip])
			redirect_to user_hike_path(@trip.user, @trip), :notice => "Updated the trip."
		else
			render :action => "edit"
		end	
	end
	def destroy
		@trip = Trip.find(params[:id])
		@user = @trip.user
		@trip.destroy
		redirect_to user_hikes_path(@user), :notice => "Deleted that trip, as requested."
	end
end
