class RoutesController < ApplicationController
	layout "map"
	def index
		@routes = Route.all
		render :layout => "application"
	end
  def new
		@route = Route.new
		@route.user_id = current_user.id unless current_user.blank?
  end
	def create
		@route = Route.new(params[:route])
		if @route.save
			respond_to do |format|
				format.js
				format.html { redirect_to route_path(@route), :notice => "Saved your route." }
			end
		end
	end
	def show
		@route = Route.find(params[:id])
	end
end
