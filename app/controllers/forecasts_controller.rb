class ForecastsController < ApplicationController
	before_filter :authorize, :only => [:new, :index, :show, :destroy, :edit, :update]

	def index
		@forecasts = current_user.forecasts
		@forecast = Forecast.new(:user_id => current_user.id)
	end
	def show
		@forecast = Forecast.find(params[:id])
	end
	def new
		@forecast = Forecast.new(:user_id => current_user.id)
	end
	def create
		@forecast = Forecast.new(params[:forecast])
		if @forecast.save
			respond_to do |format|
				format.html { redirect_to user_forecasts_path(current_user) }
				format.js { render :json => @forecast.details }
			end
		else
			respond_to do |format|
				format.html do
					@forecasts = current_user.forecasts
				 	render :index, :error => "Unable to add forecast. View the 'Add a forecast' form below for the details."  
				end
				format.js
			end
		end
	end
end