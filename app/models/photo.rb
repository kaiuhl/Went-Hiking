class Photo < ActiveRecord::Base
  belongs_to :trip
  belongs_to :user

  after_commit :add_stats, :if => :stats_not_yet_added?

  has_attached_file :image, :styles => {
    :micro => ["25x25#", :jpg],
    :thumbnail => ["125x125#", :jpg],
    :bpl => ["550x900>", :jpg],
    :large => ["900x1200>", :jpg]
  }, :convert_options => {
    :micro => "-quality 65",
    :thumbnail => "-quality 65",
    :bpl => "-quality 85",
    :large => "-quality 85"
  },
  :path => ":rails_root/public/system/:attachment/:id/:style/:filename",
  :url => "/system/:attachment/:id/:style/:filename"


  default_scope :order => "taken_at ASC, id ASC"

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

  def camera_attributes
    output = ""
    output << "Taken " + taken_at.strftime("%A, %B #{taken_at.day.ordinalize} %Y") + ", " unless taken_at.blank?
    output << camera_model unless camera_model.blank?
    output << ", f/" + camera_f_stop.to_s unless camera_f_stop.blank? || camera_f_stop == 0.0
    output << ", " + camera_exposure.to_s + "s" unless camera_exposure.blank?
    output << ", ISO " + camera_iso.to_s unless camera_iso.blank?
    output
  end

  def add_stats
      photo = MiniExiftool.new "#{Rails.root.to_s}/public#{self.image.url(:original, false)}"
      self.taken_at = photo.date_time_original
      self.lat = latlng_to_decimal(photo.gps_latitude_ref, photo.gps_latitude) unless photo.gps_latitude.blank?
      self.lng = latlng_to_decimal(photo.gps_longitude_ref, photo.gps_longitude) unless photo.gps_longitude.blank?
      self.camera_model = photo.model
      self.camera_exposure = photo.exposure_time.to_s
      self.camera_f_stop = photo.f_number.to_f
      self.camera_iso = photo.iso_speed_ratings
      self.stats_added =true
      self.save
  end

  private

  def latlng_to_decimal(ref, array)
    latlng = array[0].to_f + (array[1].to_f / 60) + (array[2].to_f / 3600 rescue 0)
    if ref == "S" || ref == "W"
      latlng *= -1
    end
    latlng
  end

  def stats_not_yet_added?
    !stats_added
  end
end
