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

ActiveRecord::Schema.define(version: 2021_10_13_183001) do

  create_table "matches", force: :cascade do |t|
    t.integer "first_member_id"
    t.integer "second_member_id"
    t.integer "winning_member_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["first_member_id"], name: "index_matches_on_first_member_id"
    t.index ["second_member_id"], name: "index_matches_on_second_member_id"
  end

  create_table "members", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "email"
    t.string "birthday"
    t.integer "games_played", default: 0
    t.integer "rank"
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "matches", "members", column: "first_member_id"
  add_foreign_key "matches", "members", column: "second_member_id"
end
