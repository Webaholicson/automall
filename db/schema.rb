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

ActiveRecord::Schema.define(version: 20160427054936) do

  create_table "admin_users", force: :cascade do |t|
    t.string   "first_name",           limit: 255
    t.string   "last_name",            limit: 255
    t.string   "password",             limit: 255
    t.string   "email",                limit: 255
    t.string   "username",             limit: 255
    t.integer  "login_count",          limit: 4,   default: 0,     null: false
    t.integer  "failed_login_count",   limit: 4,   default: 0,     null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip",     limit: 255
    t.string   "last_login_ip",        limit: 255
    t.boolean  "active",                           default: false
    t.boolean  "blocked",                          default: false
    t.string   "approval_code",        limit: 255
    t.boolean  "must_change_password",             default: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true, using: :btree
  add_index "admin_users", ["username"], name: "index_admin_users_on_username", unique: true, using: :btree

  create_table "attribute", force: :cascade do |t|
    t.integer  "type_id",     limit: 4,                     null: false
    t.string   "name",        limit: 255,                   null: false
    t.string   "label",       limit: 255,                   null: false
    t.text     "description", limit: 65535
    t.string   "type",        limit: 255,                   null: false
    t.boolean  "required",                  default: false
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  add_index "attribute", ["type_id"], name: "index_attribute_on_type_id", using: :btree

  create_table "attribute_option", force: :cascade do |t|
    t.integer  "attributes_id", limit: 4
    t.integer  "attribute_id",  limit: 4,               null: false
    t.string   "value",         limit: 255,             null: false
    t.string   "label",         limit: 255,             null: false
    t.integer  "position",      limit: 4,   default: 0
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  create_table "listings", force: :cascade do |t|
    t.integer  "user_id",    limit: 4
    t.integer  "type_id",    limit: 4
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "listings", ["user_id"], name: "index_listings_on_user_id", using: :btree

  create_table "pages", force: :cascade do |t|
    t.string   "title",       limit: 255
    t.text     "body",        limit: 65535
    t.string   "url_key",     limit: 255
    t.text     "description", limit: 65535
    t.text     "meta_keys",   limit: 65535
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "pages", ["url_key"], name: "index_pages_on_url_key", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name",         limit: 255
    t.string   "last_name",          limit: 255
    t.string   "password",           limit: 255
    t.string   "about",              limit: 255
    t.text     "phone",              limit: 65535
    t.string   "email",              limit: 255
    t.integer  "login_count",        limit: 4,     default: 0,     null: false
    t.integer  "failed_login_count", limit: 4,     default: 0,     null: false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip",   limit: 255
    t.string   "last_login_ip",      limit: 255
    t.boolean  "active",                           default: false
    t.string   "approval_code",      limit: 255
    t.boolean  "confirmed",                        default: false
    t.datetime "created_at",                                       null: false
    t.datetime "updated_at",                                       null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end
