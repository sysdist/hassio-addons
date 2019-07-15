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

ActiveRecord::Schema.define(version: 2019_07_12_095845) do

  create_table "connectors", force: :cascade do |t|
    t.string "name"
    t.string "command_topic"
    t.string "state_topic"
    t.string "json_attributes_topic"
    t.string "payload_on"
    t.string "payload_off"
    t.string "state_on"
    t.string "state_off"
    t.decimal "power"
    t.integer "voltage"
    t.decimal "i_max"
    t.decimal "price_per_kWh"
    t.integer "frequency"
    t.string "state"
    t.integer "current_user"
    t.integer "current_tnx"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "user_id"
    t.decimal "current_kWh"
    t.string "shadow_state"
    t.json "json_state"
    t.datetime "last_timestamp"
    t.index ["user_id"], name: "index_connectors_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer "debtor_id"
    t.integer "creditor_id"
    t.integer "connector_id"
    t.decimal "kWhs_used"
    t.decimal "average_price_per_kWh"
    t.string "currency"
    t.decimal "amount"
    t.date "date_posted"
    t.datetime "completed_at"
    t.string "status"
    t.decimal "meter_kWhs_start"
    t.decimal "meter_kWhs_finish"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["connector_id"], name: "index_transactions_on_connector_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
