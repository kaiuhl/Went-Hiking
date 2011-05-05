class AddIndices < ActiveRecord::Migration
  def self.up
		add_index :hikes, :user_id
		add_index :photos, :hike_id
		add_index :photos, :user_id
		add_index :hikes, :id	
		add_index :users, :id	
		
  end

  def self.down
		remove_index :users, :id
		remove_index :hikes, :id
		remove_index :photos, :user_id
		remove_index :photos, :hike_id
		remove_index :hikes, :user_id
  end
end