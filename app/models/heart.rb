class Heart < ActiveRecord::Base
	belongs_to :user
	belongs_to :trip
	default_scope :order => "created_at DESC"
	
	def self.personal(trip, user)
		self.find_or_initialize_by_trip_id_and_user_id(trip.id, user.try(:id))
	end
end
