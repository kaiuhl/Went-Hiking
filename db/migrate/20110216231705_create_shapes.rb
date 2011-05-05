class CreateShapes < ActiveRecord::Migration
  def self.up
    create_table :shapes do |t|
      t.integer :layer_id
      t.geometry :the_geom

      t.timestamps
    end
  end

  def self.down
    drop_table :shapes
  end
end
