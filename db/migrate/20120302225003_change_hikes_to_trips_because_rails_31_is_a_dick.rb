class ChangeTripsToTripsBecauseRails31IsADick < ActiveRecord::Migration
  def change
		rename_table :trips, :trips
	end
end