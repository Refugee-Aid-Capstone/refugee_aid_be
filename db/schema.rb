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

ActiveRecord::Schema[7.0].define(version: 2023_11_25_221315) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "aid_requests", force: :cascade do |t|
    t.bigint "organization_id", null: false
    t.integer "aid_type"
    t.string "language"
    t.string "description"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["organization_id"], name: "index_aid_requests_on_organization_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.string "contact_phone"
    t.string "contact_email"
    t.string "street_address"
    t.string "website"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.float "latitude"
    t.float "longitude"
    t.boolean "share_address"
    t.boolean "share_phone"
    t.boolean "share_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "volunteers", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "aid_requests", "organizations"
end
