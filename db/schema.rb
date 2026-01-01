# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.2].define(version: 2017_06_26_132453) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authentications", id: :serial, force: :cascade do |t|
    t.integer "brother_id"
    t.string "token"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["brother_id"], name: "index_authentications_on_brother_id"
    t.index ["token"], name: "index_authentications_on_token"
  end

  create_table "beans", id: :serial, force: :cascade do |t|
    t.integer "kind", default: 0
    t.integer "entry_id"
    t.integer "throw_brother_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["entry_id"], name: "index_beans_on_entry_id"
  end

  create_table "brothers", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.string "password_digest"
    t.string "remember_token"
    t.boolean "admin"
    t.string "password_reset_token"
    t.datetime "password_reset_sent_at", precision: nil
    t.index ["email"], name: "index_brothers_on_email", unique: true
    t.index ["remember_token"], name: "index_brothers_on_remember_token"
  end

  create_table "entries", id: :serial, force: :cascade do |t|
    t.integer "brother_id"
    t.text "content"
    t.string "title"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
  end

  create_table "entry_has_hashtags", id: false, force: :cascade do |t|
    t.integer "entry_id"
    t.integer "hashtag_id"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
    t.index ["entry_id", "hashtag_id"], name: "index_entry_has_hashtags_on_entry_id_and_hashtag_id", unique: true
    t.index ["entry_id"], name: "index_entry_has_hashtags_on_entry_id"
    t.index ["hashtag_id"], name: "index_entry_has_hashtags_on_hashtag_id"
  end

  create_table "hashtags", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: nil, null: false
    t.datetime "updated_at", precision: nil, null: false
  end

  create_table "relationships", id: :serial, force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", precision: nil
    t.datetime "updated_at", precision: nil
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  add_foreign_key "entry_has_hashtags", "entries"
  add_foreign_key "entry_has_hashtags", "hashtags"
end
