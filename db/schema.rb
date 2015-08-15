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

ActiveRecord::Schema.define(version: 20150814043420) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "goals", force: :cascade do |t|
    t.string   "name"
    t.datetime "starts_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean  "missed"
  end

  create_table "grades", force: :cascade do |t|
    t.date     "created_on"
    t.decimal  "score"
    t.integer  "goal"
    t.integer  "earned_points"
    t.integer  "total_points"
    t.string   "comments"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "bonus_points"
    t.integer  "penalty_points"
    t.integer  "trello_earned_points"
    t.integer  "trello_total_points"
    t.integer  "calendar_earned_points"
    t.integer  "calendar_total_points"
  end

  create_table "misc_tasks", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "weight"
    t.integer  "actual_points"
    t.integer  "total_points"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.boolean  "active"
  end

end
