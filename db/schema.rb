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

ActiveRecord::Schema[7.0].define(version: 2023_05_23_105847) do
  create_table "cards", force: :cascade do |t|
    t.string "suit"
    t.string "value"
  end

  create_table "contract_turns", force: :cascade do |t|
    t.integer "game_id", null: false
    t.integer "user_id", null: false
    t.integer "contract_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contract_id"], name: "index_contract_turns_on_contract_id"
    t.index ["game_id"], name: "index_contract_turns_on_game_id"
    t.index ["user_id"], name: "index_contract_turns_on_user_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.integer "level"
    t.string "suit"
  end

  create_table "games", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "status", default: "bidding"
    t.integer "user_id"
    t.integer "tricks_won", default: 0
  end

  create_table "hand_cards", force: :cascade do |t|
    t.integer "hand_id", null: false
    t.integer "card_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["card_id"], name: "index_hand_cards_on_card_id"
    t.index ["hand_id"], name: "index_hand_cards_on_hand_id"
  end

  create_table "hands", force: :cascade do |t|
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "game_id"
    t.index ["user_id"], name: "index_hands_on_user_id"
  end

  create_table "playables", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "game_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["game_id"], name: "index_playables_on_game_id"
    t.index ["user_id"], name: "index_playables_on_user_id"
  end

  create_table "turns", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "card_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "playable_id"
    t.integer "game_id"
    t.index ["card_id"], name: "index_turns_on_card_id"
    t.index ["user_id"], name: "index_turns_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "contract_turns", "contracts"
  add_foreign_key "contract_turns", "games"
  add_foreign_key "contract_turns", "users"
  add_foreign_key "hand_cards", "cards"
  add_foreign_key "hand_cards", "hands"
  add_foreign_key "hands", "users"
  add_foreign_key "playables", "games"
  add_foreign_key "playables", "users"
  add_foreign_key "turns", "cards"
  add_foreign_key "turns", "users"
end
