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

ActiveRecord::Schema[7.1].define(version: 2024_08_29_125840) do
  create_table "lessons", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "survey_answers", force: :cascade do |t|
    t.integer "attempt_id"
    t.integer "question_id"
    t.integer "option_id"
    t.boolean "correct", default: false, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.text "option_text"
    t.integer "option_number"
    t.integer "predefined_value_id"
  end

  create_table "survey_attempts", force: :cascade do |t|
    t.string "participant_type"
    t.integer "participant_id"
    t.integer "survey_id"
    t.boolean "winner", default: false, null: false
    t.decimal "score"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["participant_type", "participant_id"], name: "index_survey_attempts_on_participant"
  end

  create_table "survey_options", force: :cascade do |t|
    t.integer "question_id"
    t.integer "weight", default: 0
    t.string "text"
    t.boolean "correct"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "locale_text"
    t.integer "options_type_id"
    t.string "head_number"
  end

  create_table "survey_predefined_values", force: :cascade do |t|
    t.string "head_number"
    t.string "name"
    t.string "locale_name"
    t.integer "question_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "survey_questions", force: :cascade do |t|
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "section_id"
    t.string "head_number"
    t.text "description"
    t.string "locale_text"
    t.string "locale_head_number"
    t.text "locale_description"
    t.integer "questions_type_id"
    t.boolean "mandatory", default: false
  end

  create_table "survey_sections", force: :cascade do |t|
    t.string "head_number"
    t.string "name"
    t.text "description"
    t.integer "survey_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "locale_head_number"
    t.string "locale_name"
    t.text "locale_description"
  end

  create_table "survey_surveys", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "attempts_number", default: 0
    t.boolean "finished", default: false
    t.boolean "active", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "locale_name"
    t.text "locale_description"
    t.integer "lesson_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "survey_surveys", "lessons"
end
