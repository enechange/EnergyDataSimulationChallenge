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

ActiveRecord::Schema.define(version: 2019_06_25_012242) do

  create_table "cities", force: :cascade do |t|
    t.text "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_cities_on_name", unique: true
  end

  create_table "families", force: :cascade do |t|
    t.text "first_name", null: false
    t.text "last_name", null: false
    t.integer "num_of_people", null: false
    t.boolean "has_child", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "houses", force: :cascade do |t|
    t.integer "city_id"
    t.integer "family_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_houses_on_city_id"
    t.index ["family_id"], name: "index_houses_on_family_id"
  end

  create_table "monthly_energy_logs", force: :cascade do |t|
    t.integer "monthly_label_id"
    t.integer "house_id"
    t.integer "family_id"
    t.decimal "temperature", precision: 5, scale: 2, null: false
    t.decimal "daylight", precision: 5, scale: 2, null: false
    t.integer "production_volume", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["family_id"], name: "index_monthly_energy_logs_on_family_id"
    t.index ["house_id"], name: "index_monthly_energy_logs_on_house_id"
    t.index ["monthly_label_id", "house_id", "family_id"], name: "uidx01_monthly_energy_logs", unique: true
    t.index ["monthly_label_id"], name: "index_monthly_energy_logs_on_monthly_label_id"
  end

  create_table "monthly_labels", force: :cascade do |t|
    t.integer "year", null: false
    t.integer "month", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["year", "month"], name: "uidx01_monthly_labels", unique: true
  end

end
