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

ActiveRecord::Schema.define(version: 20160728191721) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "brands", force: :cascade do |t|
    t.string   "email",                    default: "", null: false
    t.string   "encrypted_password",       default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",            default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
    t.string   "brand_image_file_name"
    t.string   "brand_image_content_type"
    t.integer  "brand_image_file_size"
    t.datetime "brand_image_updated_at"
    t.string   "brand_name"
    t.string   "time_zone"
  end

  add_index "brands", ["email"], name: "index_brands_on_email", unique: true, using: :btree
  add_index "brands", ["reset_password_token"], name: "index_brands_on_reset_password_token", unique: true, using: :btree

  create_table "campaigns", force: :cascade do |t|
    t.string   "campaign_url"
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
    t.datetime "expiration_date"
    t.integer  "brand_id"
    t.string   "campaign_name"
    t.string   "brand_name"
    t.string   "description"
    t.string   "fb_description"
    t.string   "fb_image_file_name"
    t.string   "fb_image_content_type"
    t.integer  "fb_image_file_size"
    t.datetime "fb_image_updated_at"
    t.string   "promo_code"
    t.string   "alert_one"
    t.string   "alert_two"
    t.datetime "send_date_one"
    t.datetime "send_date_two"
    t.string   "banner_hex_code"
    t.string   "banner_text"
    t.integer  "fb_image_height"
    t.integer  "fb_image_width"
  end

  add_index "campaigns", ["brand_id"], name: "index_campaigns_on_brand_id", using: :btree

  create_table "deals", force: :cascade do |t|
    t.string   "uid"
    t.integer  "campaign_id"
    t.string   "campaign_url"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.datetime "expiration_date"
    t.integer  "brand_id"
    t.string   "user_name"
    t.string   "campaign_name"
    t.string   "brand_name"
    t.boolean  "display"
    t.integer  "user_id"
  end

  add_index "deals", ["campaign_id"], name: "index_deals_on_campaign_id", using: :btree
  add_index "deals", ["user_id"], name: "index_deals_on_user_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "campaign_id"
    t.datetime "send_date"
    t.boolean  "scheduled"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "alert"
    t.boolean  "stop_scheduling"
  end

  add_index "notifications", ["campaign_id"], name: "index_notifications_on_campaign_id", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "provider"
    t.string   "uid"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
    t.string   "image"
    t.string   "user_name"
    t.string   "device_token"
    t.boolean  "ios_login"
    t.float    "fb_timezone"
    t.string   "time_zone"
    t.string   "email"
    t.string   "encrypted_password"
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "widgets", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "stock"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
