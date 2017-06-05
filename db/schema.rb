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

ActiveRecord::Schema.define(version: 20170530074425) do

  create_table "applicants", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "first_name"
    t.string "father_name"
    t.string "grand_father_name"
    t.string "gender"
    t.string "email"
    t.date "date_of_birth"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "exam_results", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "exam_id"
    t.bigint "program_id"
    t.float "result", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["exam_id"], name: "index_exam_results_on_exam_id"
    t.index ["program_id"], name: "index_exam_results_on_program_id"
  end

  create_table "exams", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "applicant_id"
    t.float "aptitude_exam_result", limit: 24
    t.float "interview_result", limit: 24
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_id"], name: "index_exams_on_applicant_id"
  end

  create_table "placements", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "applicant_id"
    t.bigint "program_id"
    t.bigint "university_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_id"], name: "index_placements_on_applicant_id"
    t.index ["program_id"], name: "index_placements_on_program_id"
    t.index ["university_id"], name: "index_placements_on_university_id"
  end

  create_table "program_choices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "applicant_id"
    t.bigint "program_id"
    t.integer "choice_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["applicant_id"], name: "index_program_choices_on_applicant_id"
    t.index ["program_id"], name: "index_program_choices_on_program_id"
  end

  create_table "program_quota", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "program_id"
    t.bigint "university_id"
    t.integer "quota_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["program_id"], name: "index_program_quota_on_program_id"
    t.index ["university_id"], name: "index_program_quota_on_university_id"
  end

  create_table "programs", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "universities", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "university_choices", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.bigint "program_choice_id"
    t.bigint "university_id"
    t.integer "choice_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["program_choice_id"], name: "index_university_choices_on_program_choice_id"
    t.index ["university_id"], name: "index_university_choices_on_university_id"
  end

  add_foreign_key "exam_results", "exams"
  add_foreign_key "exam_results", "programs"
  add_foreign_key "exams", "applicants"
  add_foreign_key "placements", "applicants"
  add_foreign_key "placements", "programs"
  add_foreign_key "placements", "universities"
  add_foreign_key "program_choices", "applicants"
  add_foreign_key "program_choices", "programs"
  add_foreign_key "program_quota", "programs"
  add_foreign_key "program_quota", "universities"
  add_foreign_key "university_choices", "program_choices"
  add_foreign_key "university_choices", "universities"
end
