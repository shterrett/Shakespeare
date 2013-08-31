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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20130831100518) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "plays", force: true do |t|
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "full_text_file_name"
    t.string   "full_text_content_type"
    t.integer  "full_text_file_size"
    t.datetime "full_text_updated_at"
  end

  create_table "roles", force: true do |t|
    t.integer  "max_speech_length"
    t.text     "max_speech_text"
    t.integer  "line_count"
    t.string   "scene_list"
    t.string   "name"
    t.string   "unique_name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "play_id"
  end

end
