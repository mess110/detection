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

ActiveRecord::Schema.define(:version => 20110118121344) do

  create_table "failures", :force => true do |t|
    t.integer  "image_id"
    t.string   "message"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "images", :force => true do |t|
    t.string   "url"
    t.boolean  "completed",  :default => false
    t.boolean  "failed",     :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "runner_id"
  end

  create_table "regions", :force => true do |t|
    t.integer  "image_id"
    t.integer  "tlx"
    t.integer  "tly"
    t.integer  "brx"
    t.integer  "bry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "runners", :force => true do |t|
    t.string   "host"
    t.integer  "port"
    t.integer  "file_transfer_port"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "images_count",       :default => 0
  end

end
