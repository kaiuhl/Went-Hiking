class Shape < ActiveRecord::Base
	belongs_to :map_layer
	belongs_to :route
end
