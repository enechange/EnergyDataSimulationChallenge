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

ActiveRecord::Schema.define(version: 20140406092942) do

  create_table "energylogs", force: true do |t|
    t.integer  "id2"
    t.integer  "label"
    t.integer  "house_id"
    t.integer  "year"
    t.integer  "month"
    t.float    "templature"
    t.float    "daylight"
    t.integer  "energyproduction"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "energylogs", ["house_id"], name: "index_energylogs_on_house_id"

  create_table "houses", force: true do |t|
    t.integer  "house"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "city"
    t.integer  "n_of_people"
    t.string   "has_child"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "houses", ["house"], name: "index_houses_on_house"

end
