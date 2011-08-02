class StaticController < ApplicationController
	def home
		@hikes = Hike.all(:include => :user)
		@users = User.all
		@top_mileage = User.limit(10).order("ytd_mileage DESC")
		@top_elevation = User.where(["ytd_mileage > ? AND ytd_elevation > ?", 0, 0]).order("ytd_elevation DESC").limit(10)
		@top_nights = User.where(["ytd_nights > ? AND ytd_mileage > ?", 0, 0]).order("ytd_nights DESC").limit(10)
		@top_elevation_per_mile = User.where(["ytd_mileage >= ?", 100]).sort{|a,b| (b.ytd_elevation / b.ytd_mileage) <=> (a.ytd_elevation / a.ytd_mileage) }[0..9]
		@newest_members = User.limit(5).order("created_at DESC")
		@top_hikes = Hike.limit(5).where("")		
		@user_count = User.count
	end
	def about
	end
	def map
		render :layout => "map"
	end
	def privacy_policy
	end
end