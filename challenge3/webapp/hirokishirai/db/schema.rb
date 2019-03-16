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

ActiveRecord::Schema.define(version: 2019_03_16_072616) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", comment: "City Data", force: :cascade do |t|
    t.string "name", comment: "City Name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "houses", comment: "House Data", force: :cascade do |t|
    t.string "firstname", comment: "Resident First Name"
    t.string "lastname", comment: "Resident Last Name"
    t.bigint "city_id"
    t.integer "num_of_people", comment: "Number of Residents"
    t.boolean "has_child", comment: "Child flag"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["city_id"], name: "index_houses_on_city_id"
  end

  create_table "monthly_house_energy_productions", comment: "Monthly House Energy Production Data", force: :cascade do |t|
    t.integer "label", comment: "Label"
    t.bigint "house_id"
    t.integer "year", comment: "Production Year"
    t.integer "month", comment: "Production Month"
    t.float "temperature", comment: "Temperature"
    t.float "daylight", comment: "Label"
    t.integer "energy_production", comment: "Label"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["house_id"], name: "index_monthly_house_energy_productions_on_house_id"
  end

  add_foreign_key "houses", "cities"
  add_foreign_key "monthly_house_energy_productions", "houses"
end
