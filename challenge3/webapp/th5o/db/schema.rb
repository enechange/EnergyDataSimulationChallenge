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

ActiveRecord::Schema.define(version: 2019_05_01_055516) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "energies", force: :cascade do |t|
    t.integer "label", null: false, comment: "年月のラベル"
    t.bigint "house_id", comment: "House.id"
    t.integer "year", null: false, comment: "計測年"
    t.integer "month", null: false, comment: "計測月"
    t.integer "year_month", null: false, comment: "計測年月(yyyymm)"
    t.decimal "temperature", null: false, comment: "気温"
    t.decimal "daylight", null: false, comment: "日光"
    t.integer "energy_production", null: false, comment: "エネルギー生産量"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["daylight"], name: "index_energies_on_daylight"
    t.index ["house_id"], name: "index_energies_on_house_id"
    t.index ["temperature"], name: "index_energies_on_temperature"
    t.index ["year_month"], name: "index_energies_on_year_month"
  end

  create_table "houses", force: :cascade do |t|
    t.string "firstname", null: false, comment: "家主の名"
    t.string "lastname", null: false, comment: "家主の姓"
    t.integer "city", null: false, comment: "都市(enum)"
    t.integer "num_of_people", null: false, comment: "家庭の人数"
    t.boolean "has_child", default: false, null: false, comment: "子供の有無"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["city"], name: "index_houses_on_city"
    t.index ["has_child"], name: "index_houses_on_has_child"
    t.index ["num_of_people"], name: "index_houses_on_num_of_people"
  end

end
