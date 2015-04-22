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

ActiveRecord::Schema.define(version: 20150422131930) do

  create_table "authentications", force: :cascade do |t|
    t.integer  "brother_id"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "authentications", ["brother_id"], name: "index_authentications_on_brother_id"
  add_index "authentications", ["token"], name: "index_authentications_on_token"

  create_table "beans", force: :cascade do |t|
    t.integer  "kind",             default: 0
    t.integer  "entry_id"
    t.integer  "throw_brother_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "beans", ["entry_id"], name: "index_beans_on_entry_id"

  create_table "brothers", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
  end

  add_index "brothers", ["email"], name: "index_brothers_on_email", unique: true
  add_index "brothers", ["remember_token"], name: "index_brothers_on_remember_token"

  create_table "circuses", force: :cascade do |t|
    t.integer  "brother_id"
    t.boolean  "participation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entries", force: :cascade do |t|
    t.integer  "brother_id"
    t.text     "content"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "direct"
  end

  create_table "entry_has_hashtags", id: false, force: :cascade do |t|
    t.integer  "entry_id"
    t.integer  "hashtag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "entry_has_hashtags", ["entry_id", "hashtag_id"], name: "index_entry_has_hashtags_on_entry_id_and_hashtag_id", unique: true
  add_index "entry_has_hashtags", ["entry_id"], name: "index_entry_has_hashtags_on_entry_id"
  add_index "entry_has_hashtags", ["hashtag_id"], name: "index_entry_has_hashtags_on_hashtag_id"

  create_table "hashtags", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

  create_table "votes", force: :cascade do |t|
    t.integer  "brother_id"
    t.integer  "tshirt_id"
    t.integer  "score"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
