class AddGeoStuffAndUploadToRoutes < ActiveRecord::Migration
  def self.up
		add_column :routes, :the_geom, :geometry
		add_column :routes, :gpx_file_name, :string
		add_column :routes, :gpx_content_type, :string
		add_column :routes, :gpx_file_size, :integer
		add_column :shapes, :routes_id, :integer
  end

  def self.down
		remove_column :shapes, :routes_id
		remove_column :routes, :gpx_file_size
		remove_column :routes, :gpx_content_type
		remove_column :routes, :gpx_file_name
		remove_column :routes, :the_geom
  end
end