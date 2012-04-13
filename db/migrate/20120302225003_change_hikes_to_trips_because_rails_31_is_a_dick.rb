class ChangeHikessToTripsBecauseRails31IsADick < ActiveRecord::Migration
  def change
		rename_table :hikes, :trips
	end
end