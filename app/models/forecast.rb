class Forecast < ActiveRecord::Base
	belongs_to :user
	serialize :details
	before_create :update_forecast
	after_find :update_forecast
	validates_presence_of :lat, :lng
	
	default_scope :order => "title ASC"
	
	def update_forecast
		if self.updated_at.blank? or self.updated_at < 1.hour.ago or self.details.blank?
			self.details = NOAA.new(lat, lng)
			self.save if self.persisted?
		end
	end
end
