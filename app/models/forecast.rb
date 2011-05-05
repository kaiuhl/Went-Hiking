class Forecast < ActiveRecord::Base
	serialize :details
	before_save :update_forecast
	
	def update_forecast
		self.details = NOAA.forecast(7, self.lat, self.lng)
	end
end
