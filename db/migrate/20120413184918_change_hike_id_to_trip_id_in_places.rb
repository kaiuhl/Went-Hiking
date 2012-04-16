class ChangeHikeIdToTripIdInPlaces < ActiveRecord::Migration
  def change
		rename_column :comments, :hike_id, :trip_id
		rename_column :hearts, :hike_id, :trip_id
		rename_column :photos, :hike_id, :trip_id
  end
end