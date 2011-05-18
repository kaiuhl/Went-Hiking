class StaticController < ApplicationController
	def home
		@hikes = Hike.all
		@top_mileage = User.limit(10).order("ytd_mileage DESC")
		@top_elevation = User.where(["ytd_mileage > ? AND ytd_elevation > ?", 0, 0]).order("ytd_elevation DESC")
		@top_nights = User.where(["ytd_nights > ? AND ytd_mileage > ?", 0, 0]).order("ytd_mileage DESC")
		@newest_members = User.limit(10).order("created_at DESC")
	end
	def about
	end
	def map
	end
	def privacy_policy
	end
end