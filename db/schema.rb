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

ActiveRecord::Schema.define(version: 20130603143736) do

  create_table "accounts", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_activities", force: true do |t|
    t.integer  "project_id",            null: false
    t.integer  "project_time_entry_id"
    t.integer  "worker_id",             null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_identities", force: true do |t|
    t.integer  "project_id", null: false
    t.string   "identifier", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "project_time_entries", force: true do |t|
    t.integer  "project_id",                      null: false
    t.integer  "worker_id",                       null: false
    t.float    "hours",       default: 0.0,       null: false
    t.text     "description"
    t.string   "state",       default: "pending", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", force: true do |t|
    t.boolean  "active",     default: true, null: false
    t.string   "name"
    t.integer  "account_id",                null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                              default: "", null: false
    t.string   "encrypted_password",     limit: 128, default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
