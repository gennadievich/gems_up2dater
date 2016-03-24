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

ActiveRecord::Schema.define(version: 20160324085945) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "gem_versions", force: :cascade do |t|
    t.string   "name"
    t.date     "date"
    t.integer  "this_version_downloads"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.integer  "ruby_gem_id"
    t.boolean  "actual"
  end

  create_table "projects", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "link"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  create_table "projects_ruby_gems", id: false, force: :cascade do |t|
    t.integer "project_id",  null: false
    t.integer "ruby_gem_id", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ruby_gems", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "link"
    t.integer  "version_id"
    t.integer  "total_downloads"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.integer  "role_id",         default: 1
    t.integer  "sign_in_count",   default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end
