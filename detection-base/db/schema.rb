# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100707134231) do

  create_table "api_keys", :force => true do |t|
    t.integer  "user_id",                                     :null => false
    t.string   "key",        :limit => 10,                    :null => false
    t.string   "secret",     :limit => 10,                    :null => false
    t.boolean  "activated",                :default => false
    t.boolean  "block",                    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.string   "resource",   :limit => 400, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "queries", :force => true do |t|
    t.integer  "api_key_id", :null => false
    t.integer  "image_id",   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "regions", :force => true do |t|
    t.integer  "image_id",       :null => false
    t.integer  "top_left_x",     :null => false
    t.integer  "top_left_y",     :null => false
    t.integer  "bottom_right_x", :null => false
    t.integer  "bottom_right_y", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "email",      :limit => 32, :null => false
    t.string   "pass",       :limit => 32, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
