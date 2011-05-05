class MapLayer < ActiveRecord::Base
	include GeoRuby::Shp4r

  belongs_to :layer_group
  has_many :shapes, :dependent => :delete_all
  has_attached_file :shp, :url => "/system/:class/:id/:basename.:extension"
  has_attached_file :dbf, :url => "/system/:class/:id/:basename.:extension"
  has_attached_file :shx, :url => "/system/:class/:id/:basename.:extension"
  
  after_save :create_shapes
  
  named_scope :only, lambda { |array| { :conditions => { :layer_group_id => array } } }
  named_scope :except, lambda { |array| { :conditions => ["layer_group_id NOT IN (?)", array] } }
  
  private
  
  def create_shapes
    ShpFile.open(self.shp.path) do |shp|
      shp.each do |shape|
        @shape = Shape.new
        @shape.the_geom = shape.geometry
        @shape.layer_id = self.id
        @shape.save
      end
    end
  end
end
