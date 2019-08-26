# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_08_26_164533) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "hstore"
  enable_extension "plpgsql"

  create_table "points", force: :cascade do |t|
    t.integer "num", default: 0
    t.bigint "users_reward_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["users_reward_id"], name: "index_points_on_users_reward_id"
  end

  create_table "rewards", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "transactions", force: :cascade do |t|
    t.money "amount", scale: 2, default: "0.0"
    t.string "country"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.integer "loyalty_points", default: 0
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users_rewards", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "reward_id", null: false
    t.boolean "claimed", default: false
    t.text "comments"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["reward_id"], name: "index_users_rewards_on_reward_id"
    t.index ["user_id"], name: "index_users_rewards_on_user_id"
  end

  add_foreign_key "points", "users_rewards"
  add_foreign_key "users_rewards", "rewards"
  add_foreign_key "users_rewards", "users"
end
