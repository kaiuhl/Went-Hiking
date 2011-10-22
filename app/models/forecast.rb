class Forecast < ActiveRecord::Base
	belongs_to :user
	serialize :details
	before_create :update_forecast
	after_find :update_forecast
	validates_presence_of :lat, :lng
	
	default_scope :order => "title ASC"
	
	def update_forecast
		if self.updated_at.blank? or self.updated_at < 1.hour.ago or self.details.blank?
			self.details = jsonify(NOAA.forecast(7, lat, lng))
			self.save if self.persisted?
		end
	end
	
	private 
	
	def jsonify(noaa)
		noaa[0..4].map { |day| 
		{ 	:high => day.high, :low => day.low, 
				:title => day.starts_at.strftime("%A"),
				:daytime_precipitation_probability => day.daytime_precipitation_probability,
				:evening_precipitation_probability => day.evening_precipitation_probability,
				:weather_summary => day.weather_summary, :image_url => day.image_url }
		}.to_json
	end
end
