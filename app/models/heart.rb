class Heart < ActiveRecord::Base
	belongs_to :user
	belongs_to :hike
	default_scope :order => "created_at DESC"
	
	def self.personal(hike, user)
		self.find_or_initialize_by_hike_id_and_user_id(hike.id, user.try(:id))
	end
end
