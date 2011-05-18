class StaticController < ApplicationController
	def home
		@hikes = Hike.all(:include => :user)
		@top_mileage = User.limit(10).order("ytd_mileage DESC")
		@top_elevation = User.where(["ytd_mileage > ? AND ytd_elevation > ?", 0, 0]).order("ytd_elevation DESC").limit(5)
		@top_nights = User.where(["ytd_nights > ? AND ytd_mileage > ?", 0, 0]).order("ytd_nights DESC").limit(5)
		@newest_members = User.limit(5).order("created_at DESC")
		@top_hikes = Hike.limit(5).where("")		
		@user_count = User.count
	end
	def about
	end
	def map
	end
	def privacy_policy
	end
end