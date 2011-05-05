class CreateTracks < ActiveRecord::Migration
  def self.up
    create_table :tracks do |t|
      t.string :uri
      t.float :lat
      t.float :lng
      t.integer :zoom
      t.string :map_type
      t.text :path

      t.timestamps
    end
  end

  def self.down
    drop_table :tracks
  end
end
