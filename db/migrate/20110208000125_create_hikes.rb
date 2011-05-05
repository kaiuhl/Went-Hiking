class CreateHikes < ActiveRecord::Migration
  def self.up
    create_table :hikes do |t|
      t.string :name
      t.string :url
      t.integer :nights
      t.float :mileage
      t.integer :elevation
      t.datetime :hiked_at
      t.float :lat
      t.float :lng
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :hikes
  end
end
