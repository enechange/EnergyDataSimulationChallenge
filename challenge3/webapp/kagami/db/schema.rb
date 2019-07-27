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

ActiveRecord::Schema.define(version: 2019_07_27_134402) do

  create_table "datasets", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.integer "Label"
    t.integer "House"
    t.integer "Year"
    t.integer "Month"
    t.integer "Temperature"
    t.integer "Daylight"
    t.integer "EnergyProduction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "house_data", options: "ENGINE=InnoDB DEFAULT CHARSET=utf8", force: :cascade do |t|
    t.string "Firstname"
    t.string "Lastname"
    t.string "City"
    t.integer "num_of_people"
    t.string "has_child"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
