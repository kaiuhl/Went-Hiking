class User < ActiveRecord::Base
  validates_presence_of :name
  validates_presence_of :email
  acts_as_authentic
	has_many :hikes
	has_many :routes
	has_many :photos
	has_many :hearts
	has_many :comments
	has_many :forecasts
	
	
	has_attached_file :avatar, :styles => {
		:micro => ["25x25#", :jpg],
    :thumbnail => ["75x75#", :jpg],
		:medium => ["800x800>", :jpg],
  }
	
	def update_stats(year = DateTime.now.year)
		self.ytd_mileage = hikes.year(year).map(&:mileage).sum 
		self.ytd_elevation = hikes.year(year).map(&:elevation).sum
		self.ytd_nights = hikes.year(year).map(&:nights).sum
		
		self.ytd_mileage = 0 if self.ytd_mileage.blank?
		self.ytd_elevation = 0 if self.ytd_elevation.blank?
		self.ytd_nights = 0 if self.ytd_nights.blank?
		
		self.save
	end
	
	def to_param
    "#{id}-#{name.downcase.gsub(/[^[:alnum:]]/, '-')}".gsub(/-{2,}/, "-")
  end
end
