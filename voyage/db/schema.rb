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

ActiveRecord::Schema[7.1].define(version: 2023_05_12_065059) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "order_status", ["completed", "processed"]

  create_table "order_inbox_items", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "event_key", null: false
    t.integer "bucket", null: false
    t.integer "status", default: 0, null: false
    t.jsonb "options"
    t.binary "payload", null: false
    t.integer "errors_count", default: 0, null: false
    t.text "error_log"
    t.datetime "processed_at", precision: nil
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["created_at"], name: "index_order_inbox_items_on_created_at"
    t.index ["event_key"], name: "index_order_inbox_items_on_event_key"
    t.index ["status", "bucket"], name: "index_order_inbox_items_on_status_and_bucket"
    t.index ["uuid"], name: "index_order_inbox_items_on_uuid", unique: true
  end

  create_table "orders", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "name", null: false
    t.integer "qty", null: false
    t.enum "status", default: "completed", null: false, enum_type: "order_status"
    t.decimal "price", precision: 10, scale: 2, null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uuid"], name: "index_orders_on_uuid", unique: true
  end

end
