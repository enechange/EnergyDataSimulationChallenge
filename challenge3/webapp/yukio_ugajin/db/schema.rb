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

ActiveRecord::Schema.define(version: 2019_11_19_145638) do

  create_table "energy_details", force: :cascade do |t|
    t.integer "label", null: false
    t.integer "house_id", null: false
    t.integer "year", null: false
    t.integer "month", null: false
    t.float "temperature", null: false
    t.float "daylight", null: false
    t.integer "energy_production", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["house_id"], name: "index_energy_details_on_house_id"
  end

  create_table "houses", force: :cascade do |t|
    t.string "firstname", null: false
    t.string "lastname", null: false
    t.integer "city", null: false
    t.integer "num_of_people", null: false
    t.boolean "has_child", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "energy_details", "houses"
end
