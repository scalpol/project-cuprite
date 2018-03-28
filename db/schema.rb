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

ActiveRecord::Schema.define(version: 20180327172544) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
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
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "billings", force: :cascade do |t|
    t.string "code"
    t.string "payment_method"
    t.decimal "paid_amount", precision: 8, scale: 2
    t.string "currency"
    t.decimal "orb_price", precision: 4, scale: 2
    t.integer "total_orbs"
    t.boolean "paid", default: false
    t.bigint "player_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_billings_on_player_id"
  end

  create_table "challenge_tags", force: :cascade do |t|
    t.bigint "challenge_id"
    t.bigint "tag_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id"], name: "index_challenge_tags_on_challenge_id"
    t.index ["tag_id"], name: "index_challenge_tags_on_tag_id"
  end

  create_table "challenges", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.boolean "local"
    t.integer "capped"
    t.integer "status", default: 0
    t.integer "block_size"
    t.datetime "closing_date"
    t.datetime "expiration_date"
    t.bigint "language_id"
    t.bigint "winner_party_id"
    t.bigint "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "min_honor", default: 0.0
    t.string "picture"
    t.index ["creator_id"], name: "index_challenges_on_creator_id"
    t.index ["language_id"], name: "index_challenges_on_language_id"
    t.index ["winner_party_id"], name: "index_challenges_on_winner_party_id"
  end

  create_table "countries", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "levels", force: :cascade do |t|
    t.string "name"
    t.string "picture"
    t.integer "points_required"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "participations", force: :cascade do |t|
    t.integer "blocks"
    t.bigint "player_id"
    t.bigint "party_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["party_id"], name: "index_participations_on_party_id"
    t.index ["player_id"], name: "index_participations_on_player_id"
  end

  create_table "parties", force: :cascade do |t|
    t.string "description"
    t.integer "weight"
    t.bigint "challenge_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id"], name: "index_parties_on_challenge_id"
  end

  create_table "players", force: :cascade do |t|
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
    t.string "username", null: false
    t.bigint "level_id"
    t.float "honor", default: 0.0
    t.string "picture"
    t.integer "arbitrator_level", default: 0
    t.bigint "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_players_on_country_id"
    t.index ["email"], name: "index_players_on_email", unique: true
    t.index ["level_id"], name: "index_players_on_level_id"
    t.index ["reset_password_token"], name: "index_players_on_reset_password_token", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "verifiers", force: :cascade do |t|
    t.string "description"
    t.bigint "challenge_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["challenge_id"], name: "index_verifiers_on_challenge_id"
  end

  create_table "wallets", force: :cascade do |t|
    t.integer "orbs"
    t.boolean "active"
    t.string "owner_type"
    t.bigint "owner_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["owner_type", "owner_id"], name: "index_wallets_on_owner_type_and_owner_id"
  end

  add_foreign_key "billings", "players"
  add_foreign_key "challenge_tags", "challenges"
  add_foreign_key "challenge_tags", "tags"
  add_foreign_key "challenges", "languages"
  add_foreign_key "challenges", "parties", column: "winner_party_id"
  add_foreign_key "challenges", "players", column: "creator_id"
  add_foreign_key "participations", "parties"
  add_foreign_key "participations", "players"
  add_foreign_key "parties", "challenges"
  add_foreign_key "players", "countries"
  add_foreign_key "players", "levels"
  add_foreign_key "verifiers", "challenges"
end
