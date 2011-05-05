class AddPhoto < ActiveRecord::Migration
  def self.up
		create_table :photos, :force => true do |t|
		  t.string 		:image_file_name
		  t.string 		:image_content_type
		  t.integer 	:image_file_size
		  t.datetime 	:image_updated_at
		  t.integer 	:width
		  t.integer 	:height
		  t.datetime 	:taken_at
		  t.float 		:lat
		  t.float 		:lng
			t.string 		:caption
			t.integer 	:hike_id
			t.integer 	:user_id
			t.string 		:camera_model
			t.string 		:camera_exposure
			t.float 		:camera_f_stop
			t.integer 	:camera_iso
		  t.timestamps
		end
  end

  def self.down
		drop_table :photos
  end
end