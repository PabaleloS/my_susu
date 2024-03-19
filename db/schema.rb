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

ActiveRecord::Schema[7.1].define(version: 2024_03_18_211140) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deposits", force: :cascade do |t|
    t.bigint "member_id", null: false
    t.date "date"
    t.bigint "susu_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "agree_amount"
    t.index ["member_id"], name: "index_deposits_on_member_id"
    t.index ["susu_id"], name: "index_deposits_on_susu_id"
  end

  create_table "members", force: :cascade do |t|
    t.bigint "susu_id", null: false
    t.float "balance"
    t.date "join_date"
    t.bigint "user_id", null: false
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "has_received_disbursement", default: false
    t.date "disbursement_date"
    t.index ["susu_id"], name: "index_members_on_susu_id"
    t.index ["user_id"], name: "index_members_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "susu_id", null: false
    t.bigint "member_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["member_id"], name: "index_messages_on_member_id"
    t.index ["susu_id"], name: "index_messages_on_susu_id"
  end

  create_table "susus", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "name"
    t.text "description"
    t.float "balance"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "agree_amount"
    t.index ["user_id"], name: "index_susus_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.float "balance"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "deposits", "members"
  add_foreign_key "deposits", "susus"
  add_foreign_key "members", "susus"
  add_foreign_key "members", "users"
  add_foreign_key "messages", "members"
  add_foreign_key "messages", "susus"
  add_foreign_key "susus", "users"
end
