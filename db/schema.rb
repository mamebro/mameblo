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
    migration 20120611112223, "", ""
    migration 20120611120316, "", ""
    migration 20120612055825, "", ""
    migration 20120613084159, "", ""
    migration 20120717164053, "", ""
    migration 20120718224804, "", ""
    migration 20120719123837, "", ""
    migration 20121009135012, "", ""
    migration 20121210141646, "bda427a8fdef4a65b9622f826de39c46", "create_beans"
    migration 20121210144106, "fdb50f914a242d075e82a289add8c1ec", "add_beans_migration"
  end

  create_table "beans", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
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
