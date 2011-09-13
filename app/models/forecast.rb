class Forecast < ActiveRecord::Base
	belongs_to :user
	serialize :details
	before_save :update_forecast
	
	def update_forecast
		self.details = NOAA.forecast(7, self.lat, self.lng)
	end
end
