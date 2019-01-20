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

ActiveRecord::Schema.define(version: 2018_12_23_063348) do

  create_table "data_sets", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.integer "label", null: false, unsigned: true
    t.bigint "house_id", null: false, unsigned: true
    t.integer "year", limit: 2, null: false, unsigned: true
    t.integer "month", limit: 1, null: false, unsigned: true
    t.float "temperature", default: 0.0, null: false
    t.float "daylight", default: 0.0, null: false
    t.integer "energy_production", null: false, unsigned: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["label"], name: "index_data_sets_on_label"
    t.index ["month"], name: "index_data_sets_on_month"
    t.index ["year"], name: "index_data_sets_on_year"
  end

  create_table "houses", id: :bigint, unsigned: true, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_bin", force: :cascade do |t|
    t.string "firstname", null: false
    t.string "lastname", null: false
    t.string "city", null: false
    t.integer "num_of_people", default: 1, null: false, unsigned: true
    t.boolean "has_child", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city"], name: "index_houses_on_city"
  end

end
