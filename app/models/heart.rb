class Heart < ActiveRecord::Base
	belongs_to :user
	belongs_to :hike
	default_scope :order => "created_at DESC"
end
