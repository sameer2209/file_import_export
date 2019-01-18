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

ActiveRecord::Schema.define(version: 2019_01_17_052502) do

  create_table "inventories", force: :cascade do |t|
    t.string "item_type"
    t.string "sku"
    t.string "Title"
    t.string "serial_number"
    t.integer "quantity"
    t.float "price"
    t.string "organization"
    t.float "Length"
    t.float "Breadth"
    t.float "Height"
    t.float "Weight"
    t.string "description"
    t.string "short_description"
    t.string "asset_code"
    t.string "grade"
    t.string "category"
    t.string "brand"
    t.float "volume"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
