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

ActiveRecord::Schema.define(version: 20140703004455) do

  create_table "energies", force: true do |t|
    t.integer  "house_id"
    t.integer  "label"
    t.datetime "month"
    t.float    "temperature"
    t.float    "daylight"
    t.integer  "energy_production"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "energies", ["house_id"], name: "index_energies_on_house_id", using: :btree

  create_table "houses", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "city"
    t.integer  "num_of_people"
    t.integer  "has_child"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
