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

ActiveRecord::Schema.define(version: 20150816231432) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "hstore"

  create_table "app_apis", force: :cascade do |t|
    t.string   "name"
    t.datetime "last_updated"
    t.hstore   "api_keys"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "user_id"
  end

  create_table "goals", force: :cascade do |t|
    t.string   "name"
    t.datetime "starts_at"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.boolean  "missed",     default: true
    t.integer  "user_id"
    t.integer  "weight"
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
    t.integer  "user_id"
    t.integer  "misc_earned_points"
    t.integer  "misc_total_points"
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
    t.integer  "user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
