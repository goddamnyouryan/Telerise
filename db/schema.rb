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

ActiveRecord::Schema.define(:version => 20110515084459) do

  create_table "comments", :force => true do |t|
    t.text     "message"
    t.integer  "video_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "votes_up",   :default => 0, :null => false
    t.integer  "votes_down", :default => 0, :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "name"
    t.string   "login"
    t.integer  "points"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "videos", :force => true do |t|
    t.string   "url"
    t.string   "title"
    t.text     "description"
    t.string   "provider"
    t.integer  "height"
    t.integer  "width"
    t.text     "embed"
    t.string   "thumb"
    t.integer  "thumb_height"
    t.integer  "thumb_width"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.integer  "votes_up",     :default => 0, :null => false
    t.integer  "votes_down",   :default => 0, :null => false
  end

  create_table "votes", :force => true do |t|
    t.string   "vote"
    t.integer  "user_id"
    t.integer  "votable_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "votable_type"
  end

end
