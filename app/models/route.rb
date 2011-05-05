class Route < ActiveRecord::Base
	belongs_to :user
	has_many :shapes
	
	def to_param
    "#{id}-#{title.downcase.gsub(/[^[:alnum:]]/, '-')}".gsub(/-{2,}/, "-")
  end
end
