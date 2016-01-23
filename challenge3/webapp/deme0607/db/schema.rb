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

ActiveRecord::Schema.define(version: 20160123121651) do

  create_table "cities", force: :cascade do |t|
    t.string   "name",       limit: 255, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "cities", ["name"], name: "index_cities_on_name", unique: true, using: :btree

  create_table "houses", force: :cascade do |t|
    t.string   "first_name",    limit: 255, null: false
    t.string   "last_name",     limit: 255, null: false
    t.integer  "city_id",       limit: 4,   null: false
    t.integer  "num_of_people", limit: 4,   null: false
    t.boolean  "has_child",                 null: false
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "houses", ["city_id"], name: "fk_rails_04b1ffb10d", using: :btree

  add_foreign_key "houses", "cities"
end
