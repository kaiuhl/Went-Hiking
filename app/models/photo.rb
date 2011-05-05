class Photo < ActiveRecord::Base  
	belongs_to :hike
	belongs_to :user
	
  after_commit_on_create :add_stats
  
  has_attached_file :image, :styles => {
		:micro => ["25x25#", :jpg],
    :thumbnail => ["125x125#", :jpg],
		:medium => ["200x200#", :jpg],
		:bpl => ["550x900>", :jpg],
    :large => ["800x1000>", :jpg]
  }
  
  default_scope :order => "photos.taken_at ASC"
  
  validates_attachment_presence :image
  
  validates_attachment_content_type :image, :content_type => [
    'image/jpg',
    'image/jpeg',
    'image/pjpeg',
    'image/gif',
    'image/png',
    'image/x-png'
  ], :message => "file is incorrect. Image files allowed: .jpg, .gif, .png"
  
  validates_attachment_size :image,
    :less_than      => 10.megabytes,
    :greater_than   => 1.kilobyte,
    :message        => "maximum size is 10 megabytes. Please reduce the file size."
  
  def self.search(terms)
    collector = []
    for term in terms.split
      collector << Photo.tagged_with('%#{term}%', :on => :tags)
    end
    collector
  end
  
  def embedded_information
    @magick = mini_magick
    
    existing_tags = []
    existing_tags << @magick["%[IPTC:2:92]"]    #Location
    existing_tags << @magick["%[IPTC:2:90]"]    #City
    existing_tags << @magick["%[IPTC:2:95]"]    #State
    existing_tags << @magick["%[IPTC:2:101]"]   #Country
    tags = @magick["%[IPTC:2:25]"]              #Keywords
    unless tags.blank?
      existing_tags.concat tags.split(";")
    end
    existing_tags
  end

	def camera_attributes
		output = ""
		output << "Taken " + taken_at.strftime("%A, %B #{taken_at.day.ordinalize} %Y") + ", " unless taken_at.blank?
		output << camera_model unless camera_model.blank?
		output << ", ƒ/" + camera_f_stop.to_s unless camera_f_stop.blank? || camera_f_stop == 0.0
		output << ", " + camera_exposure.to_s + "s" unless camera_exposure.blank?
		output << ", ISO " + camera_iso.to_s unless camera_iso.blank?
	end
	
	def add_stats
    self.width, self.height = self.image.width.to_i, self.image.height.to_i
    @magick = mini_magick
    self.taken_at = parse_exif_date exif(@magick, "DateTimeOriginal")
		
		if self.image_content_type == "image/jpeg"
			exifr = EXIFR::JPEG.new("#{RAILS_ROOT}/public#{self.image.url(:original, false)}")
			self.lat = latlng_to_decimal(exifr.gps_latitude_ref, exifr.gps_latitude) unless exifr.gps_latitude.blank?
			self.lng = latlng_to_decimal(exifr.gps_longitude_ref, exifr.gps_longitude) unless exifr.gps_longitude.blank?
			self.camera_model = exifr.model
			self.camera_exposure = exifr.exposure_time.to_s
			self.camera_f_stop = exifr.f_number.to_f
			self.camera_iso = exifr.iso_speed_ratings
		end
		self.save
  end
  
  private  
  
  def mini_magick
    MiniMagick::Image.from_file("#{RAILS_ROOT}/public#{self.image.url(:original, false)}")
  end
  
  def exif(photo, tag)
      photo["EXIF:#{tag}"] != "" ? photo["EXIF:#{tag}"] : nil
  end
  
  def parse_exif_date(date)
      unless date.blank?
        date = date.split.collect{|d| d.split(":")}
        date = Date.parse("#{date[0][1]}/#{date[0][2]}/#{date[0][0]}")
      end
  end

	def latlng_to_decimal(ref, array)
		latlng = array[0].to_f + (array[1].to_f / 60) + (array[2].to_f / 3600 rescue 0)
		if ref == "S" || ref == "W"
			latlng *= -1
		end
		latlng
	end
end