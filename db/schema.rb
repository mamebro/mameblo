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

ActiveRecord::Schema.define do

  migrations do
    migration 20120611112223, "efa3c17c0d86ab780b11dcbf141b9cd3", "create_brothers"
    migration 20120611120316, "05b0e7cc41008830d5f2240b0eebb772", "add_password_digest_to_brothers"
    migration 20120612055825, "ef2f95ab51fd39b76447caafedceb83e", "add_remember_token_to_brothers"
    migration 20120613084159, "639eee2fbab4706bc054e56f631bfb06", "create_entries"
    migration 20120717164053, "1f05f32ef3c7f091af43c06638446bc4", "add_index_to_brothers_email"
    migration 20120718224804, "21ecc0765737d18c666a74d0eb7f02aa", "add_admin_to_brothers"
    migration 20120719123837, "5d9b62d5f2f78567b246e6afe31cdef5", "create_relationships"
    migration 20121009135012, "13a9b52639644e80427bc5ef8be3c3ff", "create_circuses"
  end

  create_table "brothers", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin"
  end

  add_index "brothers", ["email"], name: "index_brothers_on_email", unique: true
  add_index "brothers", ["remember_token"], name: "index_brothers_on_remember_token"

  create_table "circuses", force: true do |t|
    t.integer  "brother_id"
    t.boolean  "participation"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "entries", force: true do |t|
    t.integer  "brother_id"
    t.text     "content"
    t.string   "title"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "relationships", force: true do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "relationships", ["followed_id"], name: "index_relationships_on_followed_id"
  add_index "relationships", ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
  add_index "relationships", ["follower_id"], name: "index_relationships_on_follower_id"

end
