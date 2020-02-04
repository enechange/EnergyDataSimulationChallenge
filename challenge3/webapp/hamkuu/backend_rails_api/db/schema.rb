# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_01_02_143756) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "house_owners", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "household_energy_records", force: :cascade do |t|
    t.bigint "house_id", null: false
    t.date "record_date"
    t.decimal "temperature", precision: 4, scale: 1
    t.decimal "daylight", precision: 5, scale: 1
    t.decimal "energy_production", precision: 5
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["house_id"], name: "index_household_energy_records_on_house_id"
  end

  create_table "houses", force: :cascade do |t|
    t.bigint "house_owner_id", null: false
    t.integer "residents_count"
    t.boolean "has_children"
    t.string "city"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["house_owner_id"], name: "index_houses_on_house_owner_id"
  end

  add_foreign_key "household_energy_records", "houses"
  add_foreign_key "houses", "house_owners"
end
