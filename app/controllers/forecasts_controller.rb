class ForecastsController < ApplicationController
	def create
		@forecast = Forecast.find_or_create_by_lat_and_lng(params[:lat], params[:lng])
		@forecast.save if @forecast.created_at <= 1.hour.ago
		respond_to do |format|
			format.js do
				render :json => @forecast.details[0..4].map { |day| 
					{ :high => day.high, :low => day.low, 
						:title => day.starts_at.strftime("%A"),
						:daytime_precipitation_probability => day.daytime_precipitation_probability,
						:evening_precipitation_probability => day.evening_precipitation_probability,
						:weather_summary => day.weather_summary, :image_url => day.image_url }
				}.to_json
			end
		end
	end
end