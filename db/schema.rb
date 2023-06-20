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

ActiveRecord::Schema.define(version: 2023_06_20_091239) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "agenda_boards", force: :cascade do |t|
    t.integer "user_id"
    t.string "agenda"
    t.string "category"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "conclusions", force: :cascade do |t|
    t.integer "agenda_board_id"
    t.string "conclusion_summary"
    t.text "conclusion_detail"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.index ["user_id"], name: "index_conclusions_on_user_id"
  end

  create_table "evidences", force: :cascade do |t|
    t.integer "reason_id"
    t.string "evidence_summary"
    t.text "evidence_detail"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "opinion_connections", force: :cascade do |t|
    t.string "source_id"
    t.string "target_id"
    t.string "source_endpoint_id"
    t.string "target_endpoint_id"
  end

  create_table "opinion_positions", force: :cascade do |t|
    t.bigint "argument_id"
    t.bigint "refutation_id"
    t.integer "left"
    t.integer "top"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["argument_id"], name: "index_opinion_positions_on_argument_id", unique: true
    t.index ["refutation_id"], name: "index_opinion_positions_on_refutation_id", unique: true
  end

  create_table "reasons", force: :cascade do |t|
    t.integer "conclusion_id"
    t.string "reason_summary"
    t.text "reason_detail"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "ref_conclusions", force: :cascade do |t|
    t.bigint "agenda_board_id", null: false
    t.string "ref_conclusion_summary"
    t.text "ref_conclusion_detail"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id"
    t.bigint "conclusion_id"
    t.bigint "parent_ref_conclusion_id"
    t.index ["agenda_board_id"], name: "index_ref_conclusions_on_agenda_board_id"
    t.index ["conclusion_id"], name: "index_ref_conclusions_on_conclusion_id"
    t.index ["parent_ref_conclusion_id"], name: "index_ref_conclusions_on_parent_ref_conclusion_id"
    t.index ["user_id"], name: "index_ref_conclusions_on_user_id"
  end

  create_table "ref_evidences", force: :cascade do |t|
    t.bigint "ref_reason_id", null: false
    t.string "ref_evidence_summary"
    t.text "ref_evidence_detail"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ref_reason_id"], name: "index_ref_evidences_on_ref_reason_id"
  end

  create_table "ref_reasons", force: :cascade do |t|
    t.bigint "ref_conclusion_id", null: false
    t.string "ref_reason_summary"
    t.text "ref_reason_detail"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ref_conclusion_id"], name: "index_ref_reasons_on_ref_conclusion_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "conclusions", "users"
  add_foreign_key "opinion_positions", "conclusions", column: "argument_id"
  add_foreign_key "opinion_positions", "ref_conclusions", column: "refutation_id"
  add_foreign_key "ref_conclusions", "agenda_boards"
  add_foreign_key "ref_conclusions", "conclusions"
  add_foreign_key "ref_conclusions", "ref_conclusions", column: "parent_ref_conclusion_id"
  add_foreign_key "ref_conclusions", "users"
  add_foreign_key "ref_evidences", "ref_reasons"
  add_foreign_key "ref_reasons", "ref_conclusions"
end
