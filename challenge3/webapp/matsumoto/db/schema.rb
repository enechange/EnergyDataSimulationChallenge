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

ActiveRecord::Schema.define(version: 20160911051700) do

  create_table "cities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "energies", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "label",                        null: false
    t.date     "record_at",                    null: false
    t.float    "temperature",       limit: 24, null: false
    t.float    "daylight",          limit: 24, null: false
    t.integer  "energy_production",            null: false
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.integer  "house_id"
    t.index ["house_id"], name: "index_energies_on_house_id", using: :btree
  end

  create_table "houses", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "first_name",    null: false
    t.string   "last_name",     null: false
    t.integer  "num_of_people", null: false
    t.boolean  "has_child",     null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "city_id"
    t.index ["city_id"], name: "index_houses_on_city_id", using: :btree
  end

  add_foreign_key "energies", "houses"
  add_foreign_key "houses", "cities"
end
