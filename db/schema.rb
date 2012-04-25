# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120425030143) do

  create_table "assets", :force => true do |t|
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "attachings_count",  :default => 0
    t.datetime "created_at"
    t.datetime "data_updated_at"
  end

  create_table "attachings", :force => true do |t|
    t.integer  "attachable_id"
    t.integer  "asset_id"
    t.string   "attachable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "attachings", ["asset_id"], :name => "index_attachings_on_asset_id"
  add_index "attachings", ["attachable_id"], :name => "index_attachings_on_attachable_id"

  create_table "comments", :force => true do |t|
    t.integer  "user_id"
    t.integer  "trip_id"
    t.text     "body"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "forecasts", :force => true do |t|
    t.float    "lat"
    t.float    "lng"
    t.text     "details"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
    t.string   "title"
  end

  create_table "gpxes", :force => true do |t|
    t.integer  "hike_id"
    t.string   "data_file_name"
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "hearts", :force => true do |t|
    t.integer  "user_id"
    t.integer  "trip_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "map_layers", :force => true do |t|
    t.string   "title"
    t.string   "shp_file_name"
    t.string   "shp_content_type"
    t.integer  "shp_file_size"
    t.string   "shx_file_name"
    t.string   "shx_content_type"
    t.integer  "shx_file_size"
    t.string   "dbf_file_name"
    t.string   "dbf_content_type"
    t.integer  "dbf_file_size"
    t.datetime "shp_updated_at"
    t.datetime "shx_updated_at"
    t.datetime "dbf_updated_at"
    t.integer  "layer_group_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "messages", :force => true do |t|
    t.integer  "to"
    t.integer  "from"
    t.text     "body"
    t.string   "subject"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "notifications", :force => true do |t|
    t.integer  "user_id"
    t.string   "content_type"
    t.integer  "content_id"
    t.string   "creator_type"
    t.integer  "creator_id"
    t.string   "uri"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "photos", :force => true do |t|
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.integer  "width"
    t.integer  "height"
    t.datetime "taken_at"
    t.float    "lat"
    t.float    "lng"
    t.string   "caption"
    t.integer  "trip_id"
    t.integer  "user_id"
    t.string   "camera_model"
    t.string   "camera_exposure"
    t.float    "camera_f_stop"
    t.integer  "camera_iso"
    t.datetime "created_at",                            :null => false
    t.datetime "updated_at",                            :null => false
    t.boolean  "stats_added",        :default => false
  end

  add_index "photos", ["trip_id"], :name => "index_photos_on_hike_id"
  add_index "photos", ["user_id"], :name => "index_photos_on_user_id"

# Could not dump table "routes" because of following StandardError
#   Unknown type 'geometry' for column 'the_geom'

  create_table "shapes", :force => true do |t|
    t.integer  "layer_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "routes_id"
  end

  create_table "tracks", :force => true do |t|
    t.string   "uri"
    t.float    "lat"
    t.float    "lng"
    t.integer  "zoom"
    t.string   "map_type"
    t.text     "path"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "trips", :force => true do |t|
    t.string   "name"
    t.string   "url"
    t.integer  "nights",     :default => 0
    t.float    "mileage"
    t.integer  "elevation"
    t.datetime "hiked_at"
    t.float    "lat"
    t.float    "lng"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "report"
  end

  add_index "trips", ["id"], :name => "index_hikes_on_id"
  add_index "trips", ["user_id"], :name => "index_hikes_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "persistence_token"
    t.datetime "last_login_at"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "ytd_mileage"
    t.integer  "ytd_elevation"
    t.integer  "ytd_nights"
    t.string   "location"
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.string   "locale"
    t.boolean  "notify_on_comment",   :default => true
    t.datetime "last_request_at"
  end

  add_index "users", ["id"], :name => "index_users_on_id"

end
