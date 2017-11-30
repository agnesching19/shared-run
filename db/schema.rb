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

ActiveRecord::Schema.define(version: 20171130133503) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bookings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "run_id"
    t.index ["run_id"], name: "index_bookings_on_run_id"
    t.index ["user_id"], name: "index_bookings_on_user_id"
  end

  create_table "event_searches", force: :cascade do |t|
    t.bigint "user_id"
    t.string "location"
    t.float "proximity", default: 10.0
    t.integer "run_distance"
    t.date "run_date"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_event_searches_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.date "date"
    t.time "time"
    t.string "location"
    t.text "description"
    t.integer "run_distance"
    t.integer "price"
    t.string "surface"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "invites", force: :cascade do |t|
    t.string "status"
    t.bigint "run_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["run_id"], name: "index_invites_on_run_id"
    t.index ["user_id"], name: "index_invites_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "run_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["run_id"], name: "index_messages_on_run_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "preferences", force: :cascade do |t|
    t.time "time"
    t.date "date"
    t.string "location"
    t.integer "sociability"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_preferences_on_user_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "event_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["event_id"], name: "index_reservations_on_event_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "run_id"
    t.boolean "punctuality"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["run_id"], name: "index_reviews_on_run_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "runs", force: :cascade do |t|
    t.bigint "user_id"
    t.string "location"
    t.date "date"
    t.text "description"
    t.integer "run_distance"
    t.integer "capacity"
    t.string "photo"
    t.boolean "shared"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "latitude"
    t.float "longitude"
    t.string "title"
    t.time "time"
    t.time "pace"
    t.index ["user_id"], name: "index_runs_on_user_id"
  end

  create_table "searches", force: :cascade do |t|
    t.bigint "user_id"
    t.string "location"
    t.float "latitude"
    t.float "longitude"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "proximity", default: 3.0
    t.date "run_date"
    t.time "run_time"
    t.integer "sociability"
    t.integer "run_distance"
    t.time "pace"
    t.index ["user_id"], name: "index_searches_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "photo"
    t.integer "sociability"
    t.string "location"
    t.time "pace"
    t.string "schedule"
    t.string "provider"
    t.string "uid"
    t.string "facebook_picture_url"
    t.string "token"
    t.datetime "token_expiry"
    t.text "bio"
    t.string "nike"
    t.string "strava"
    t.string "power"
    t.boolean "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bookings", "runs"
  add_foreign_key "bookings", "users"
  add_foreign_key "event_searches", "users"
  add_foreign_key "events", "users"
  add_foreign_key "invites", "runs"
  add_foreign_key "invites", "users"
  add_foreign_key "messages", "runs"
  add_foreign_key "preferences", "users"
  add_foreign_key "reservations", "events"
  add_foreign_key "reservations", "users"
  add_foreign_key "reviews", "runs"
  add_foreign_key "reviews", "users"
  add_foreign_key "runs", "users"
  add_foreign_key "searches", "users"
end
