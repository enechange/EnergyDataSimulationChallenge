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

ActiveRecord::Schema.define(version: 2019_08_21_071919) do

  create_table "energies", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.integer "label", null: false
    t.integer "house_id", null: false
    t.integer "year", null: false
    t.integer "month", null: false
    t.decimal "temperature", precision: 3, scale: 1, null: false
    t.decimal "daylight", precision: 4, scale: 1, null: false
    t.integer "energy_production", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["house_id", "year", "month"], name: "index_energies_on_house_id_and_year_and_month", unique: true
  end

  create_table "houses", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4", force: :cascade do |t|
    t.string "firstname", null: false
    t.string "lastname", null: false
    t.string "city", null: false
    t.integer "num_of_people", default: 0, null: false
    t.boolean "has_child", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
