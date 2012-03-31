class NOAAPresenter
	def self.get_forecast(lat,lng)
		@response = NOAA.forecast(7, lat, lng)
		return parse(@response)
	end
	
	private
	
	def self.parse(response)
		response[0..4].map { |day| 
		{ 	:high => day.high, :low => day.low, 
				:title => day.starts_at.strftime("%A"),
				:daytime_precipitation_probability => day.daytime_precipitation_probability,
				:evening_precipitation_probability => day.evening_precipitation_probability,
				:weather_summary => day.weather_summary, :image_url => day.image_url }
		}.to_json
	end
end