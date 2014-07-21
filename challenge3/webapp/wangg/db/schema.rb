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

ActiveRecord::Schema.define(version: 20140719061908) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_users", force: true do |t|
    t.string   "username",        limit: 25
    t.string   "password_digest"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "energies", force: true do |t|
    t.integer  "label"
    t.integer  "house_id"
    t.integer  "year"
    t.integer  "month"
    t.float    "temperature"
    t.float    "daylight"
    t.integer  "energy_production"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "houses", force: true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "city"
    t.integer  "num_of_people"
    t.boolean  "has_child"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
