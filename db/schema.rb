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

ActiveRecord::Schema.define(version: 15) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: :cascade do |t|
    t.string   "name"
    t.string   "preferred_security_group"
    t.string   "tag"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "server_images", force: :cascade do |t|
    t.string   "ami_id",      null: false
    t.string   "name"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "archived_at"
    t.integer  "game_id"
  end

  add_index "server_images", ["game_id"], name: "index_server_images_on_game_id", using: :btree

  create_table "servers", force: :cascade do |t|
    t.string   "instance_id"
    t.string   "status"
    t.integer  "server_image_id", null: false
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "instance_type"
    t.string   "security_group"
    t.string   "public_ip"
    t.datetime "terminate_at"
    t.integer  "user_id"
    t.integer  "game_id"
  end

  add_index "servers", ["game_id"], name: "index_servers_on_game_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name",                                 null: false
    t.string   "email",                                null: false
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "facebook_id"
    t.string   "role",        default: "unauthorized", null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
