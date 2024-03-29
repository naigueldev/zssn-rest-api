# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20180817010653) do

  create_table "inventories", force: :cascade do |t|
    t.string   "item"
    t.integer  "points"
    t.integer  "quantity"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "survivor_id"
  end

  add_index "inventories", ["survivor_id"], name: "index_inventories_on_survivor_id"

  create_table "survivors", force: :cascade do |t|
    t.string   "name"
    t.integer  "age"
    t.string   "gender",              limit: 1
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "contamination_count",           default: 0
    t.datetime "created_at",                                    null: false
    t.datetime "updated_at",                                    null: false
    t.boolean  "is_infected",                   default: false
  end

end
