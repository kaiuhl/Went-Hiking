class Route < ActiveRecord::Base
	belongs_to :user
	has_many :shapes
	has_pretty_param :title
end
