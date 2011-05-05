class CreateRoutes < ActiveRecord::Migration
  def self.up
    create_table :routes do |t|
      t.string :title
      t.float :lat
      t.float :lng
      t.integer :zoom
      t.string :map_type
      t.text :path
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :routes
  end
end
