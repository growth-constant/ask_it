# encoding: UTF-8
# frozen_string_literal: true

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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(version: 20170619155608) do
  create_table 'lessons', force: true do |t|
    t.string   'name'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  create_table 'survey_answers', force: true do |t|
    t.integer  'attempt_id'
    t.integer  'question_id'
    t.integer  'option_id'
    t.boolean  'correct'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.text     'option_text'
    t.integer  'option_number'
    t.integer  'predefined_value_id'
  end

  create_table 'survey_attempts', force: true do |t|
    t.integer 'participant_id'
    t.string  'participant_type'
    t.integer 'survey_id'
    t.integer 'score'
  end

  create_table 'survey_options', force: true do |t|
    t.integer  'question_id'
    t.integer  'weight', default: 0
    t.string   'text'
    t.boolean  'correct'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.string   'locale_text'
    t.integer  'options_type_id'
    t.string   'head_number'
  end

  create_table 'survey_predefined_values', force: true do |t|
    t.string   'head_number'
    t.string   'name'
    t.string   'locale_name'
    t.integer  'question_id'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end

  create_table 'survey_questions', force: true do |t|
    t.string   'text'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.integer  'section_id'
    t.string   'head_number'
    t.text     'description'
    t.string   'locale_text'
    t.string   'locale_head_number'
    t.text     'locale_description'
    t.integer  'questions_type_id'
    t.boolean  'mandatory', default: false
  end

  create_table 'survey_sections', force: true do |t|
    t.string   'head_number'
    t.string   'name'
    t.text     'description'
    t.integer  'survey_id'
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.string   'locale_head_number'
    t.string   'locale_name'
    t.text     'locale_description'
  end

  create_table 'survey_surveys', force: true do |t|
    t.string   'name'
    t.text     'description'
    t.integer  'attempts_number',    default: 0
    t.boolean  'finished',           default: false
    t.boolean  'active',             default: true
    t.datetime 'created_at'
    t.datetime 'updated_at'
    t.string   'locale_name'
    t.text     'locale_description'
    t.integer  'lesson_id'
  end

  create_table 'users', force: true do |t|
    t.string   'name'
    t.datetime 'created_at'
    t.datetime 'updated_at'
  end
end
