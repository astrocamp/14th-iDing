# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2023_09_07_101550) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "holidays", force: :cascade do |t|
    t.string "dayoff"
    t.bigint "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_holidays_on_restaurant_id"
  end

  create_table "open_times", force: :cascade do |t|
    t.time "start_time"
    t.time "end_time"
    t.bigint "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_open_times_on_restaurant_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.date "date", null: false
    t.time "time", null: false
    t.integer "adults", null: false
    t.integer "kids", null: false
    t.string "purpose"
    t.text "note"
    t.string "serial"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "restaurant_id", null: false
    t.string "name", null: false
    t.string "email"
    t.integer "gender"
    t.string "tel", null: false
    t.datetime "deleted_at"
    t.bigint "table_id"
    t.string "state", default: "reserved"
    t.string "slug"
    t.index ["deleted_at"], name: "index_reservations_on_deleted_at"
    t.index ["restaurant_id"], name: "index_reservations_on_restaurant_id"
    t.index ["slug"], name: "index_reservations_on_slug", unique: true
    t.index ["table_id"], name: "index_reservations_on_table_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "name", null: false
    t.string "url", null: false
    t.string "tel", null: false
    t.string "address", null: false
    t.text "description"
    t.string "ubn"
    t.string "image"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reserve_interval", default: 15
    t.integer "mealtime", default: 60
    t.integer "bookday_advance", default: 14
    t.datetime "deleted_at"
    t.json "menus"
    t.string "slug"
    t.index ["deleted_at"], name: "index_restaurants_on_deleted_at"
    t.index ["slug"], name: "index_restaurants_on_slug", unique: true
  end

  create_table "tables", force: :cascade do |t|
    t.string "name"
    t.integer "seat_num"
    t.string "status"
    t.integer "category"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "restaurant_id", null: false
    t.integer "site_x", default: 1
    t.integer "site_y", default: 1
    t.index ["restaurant_id"], name: "index_tables_on_restaurant_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role", default: "user"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "holidays", "restaurants"
  add_foreign_key "open_times", "restaurants"
  add_foreign_key "reservations", "restaurants"
  add_foreign_key "reservations", "tables"
  add_foreign_key "tables", "restaurants"
end
