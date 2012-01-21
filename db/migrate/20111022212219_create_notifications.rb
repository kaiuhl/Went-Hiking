class CreateNotifications < ActiveRecord::Migration
  def self.up
    create_table :notifications do |t|
      t.integer :user_id
      t.string :content_type
      t.integer :content_id
      t.string :creator_type
      t.integer :creator_id
      t.string :uri

      t.timestamps
    end
  end

  def self.down
    drop_table :notifications
  end
end
