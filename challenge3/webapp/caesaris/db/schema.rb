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

ActiveRecord::Schema.define(version: 2019_06_19_054146) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_cities_on_name"
  end

  create_table "datasets", force: :cascade do |t|
    t.integer "label"
    t.integer "house_id"
    t.integer "year"
    t.integer "month"
    t.float "temperature"
    t.float "daylight"
    t.integer "energy_production"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["daylight"], name: "index_datasets_on_daylight"
    t.index ["energy_production"], name: "index_datasets_on_energy_production"
    t.index ["house_id"], name: "index_datasets_on_house_id"
    t.index ["label"], name: "index_datasets_on_label"
    t.index ["month"], name: "index_datasets_on_month"
    t.index ["temperature"], name: "index_datasets_on_temperature"
    t.index ["year"], name: "index_datasets_on_year"
  end

  create_table "houses", force: :cascade do |t|
    t.string "firstname"
    t.string "lastname"
    t.string "city_text"
    t.integer "city_id"
    t.integer "num_of_people"
    t.boolean "has_child"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city_id"], name: "index_houses_on_city_id"
    t.index ["city_text"], name: "index_houses_on_city_text"
    t.index ["firstname"], name: "index_houses_on_firstname"
    t.index ["has_child"], name: "index_houses_on_has_child"
    t.index ["lastname"], name: "index_houses_on_lastname"
    t.index ["num_of_people"], name: "index_houses_on_num_of_people"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
