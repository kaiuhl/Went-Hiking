class CreateGpxes < ActiveRecord::Migration
  def self.up
    create_table :gpxes do |t|
      t.integer :hike_id
      t.geometry :track
      t.string :data_file_name
      t.string :data_content_type
      t.integer :data_file_size

      t.timestamps
    end
  end

  def self.down
    drop_table :gpxes
  end
end
