class AddMileageElevationNightsHikesToUser < ActiveRecord::Migration
  def self.up
		add_column :users, :ytd_mileage, :float
		add_column :users, :ytd_elevation, :integer
		add_column :users, :ytd_nights, :integer
  end

  def self.down
		remove_column :users, :ytd_nights
		remove_column :users, :ytd_elevation
		remove_column :users, :ytd_mileage
  end
end