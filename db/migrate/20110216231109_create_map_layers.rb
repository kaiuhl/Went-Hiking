class CreateMapLayers < ActiveRecord::Migration
  def self.up
    create_table :map_layers do |t|
      t.string :title
      t.string :shp_file_name
      t.string :shp_content_type
      t.integer :shp_file_size
      t.string :shx_file_name
      t.string :shx_content_type
      t.integer :shx_file_size
      t.string :dbf_file_name
      t.string :dbf_content_type
      t.integer :dbf_file_size
      t.datetime :shp_updated_at
      t.datetime :shx_updated_at
      t.datetime :dbf_updated_at
      t.integer :layer_group_id

      t.timestamps
    end
  end

  def self.down
    drop_table :map_layers
  end
end
