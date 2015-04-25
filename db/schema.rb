# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150425140325) do

  create_table "books", force: true do |t|
    t.string   "title"
    t.string   "book_type"
    t.string   "book_type_category"
    t.string   "serial_no"
    t.integer  "count"
    t.string   "edition"
    t.string   "book_author"
    t.string   "book_publisher"
    t.integer  "thesis_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "borrows", force: true do |t|
    t.string   "book_serial_no"
    t.string   "borrower_type"
    t.integer  "borrower_id"
    t.datetime "borrow_date"
    t.datetime "return_date"
    t.boolean  "is_return"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "downloads", force: true do |t|
    t.string   "file_type"
    t.string   "title"
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "isShow"
  end

  create_table "events", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "event_type"
    t.string   "location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "post_type"
    t.datetime "end_date"
    t.text     "download_link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "students", force: true do |t|
    t.string   "stu_no"
    t.string   "stu_name"
    t.integer  "grade"
    t.integer  "gender"
    t.string   "address"
    t.string   "tel"
    t.string   "mobile"
    t.string   "email"
    t.integer  "supervisor1"
    t.integer  "supervisor2"
    t.boolean  "is_graduated"
    t.string   "job_organization"
    t.string   "job_title"
    t.string   "job_industry"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teachers", force: true do |t|
    t.string   "name_c"
    t.string   "name_e"
    t.string   "office_c"
    t.string   "office_e"
    t.text     "domain_c"
    t.text     "domain_e"
    t.string   "degree_c"
    t.string   "degree_e"
    t.integer  "title_priority"
    t.boolean  "is_chair"
    t.string   "email"
    t.string   "tel"
    t.string   "extension"
    t.integer  "employ_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "image_url"
    t.boolean  "isShow"
  end

  create_table "theses", force: true do |t|
    t.string   "name"
    t.integer  "student_id"
    t.integer  "supervisor1"
    t.integer  "year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "conference"
    t.integer  "supervisor2"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
