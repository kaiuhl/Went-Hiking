class MapLayersController < ApplicationController
	def new
		@map_layer = MapLayer.new
	end
	def create
		@map_layer = MapLayer.new(params[:map_layer])
		if @map_layer.save
      redirect_to root_path, :notice => "Success."
    else
      render :action => "new"
    end
	end
end
