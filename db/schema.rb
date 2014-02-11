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

ActiveRecord::Schema.define(version: 20140211183025) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "checkpoints", force: true do |t|
    t.string   "expectation"
    t.integer  "track_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "success_criteria"
    t.integer  "position"
  end

  add_index "checkpoints", ["track_id"], name: "index_checkpoints_on_track_id", using: :btree

  create_table "classroom_teachers", force: true do |t|
    t.integer  "classroom_id"
    t.integer  "teacher_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "classroom_teachers", ["classroom_id"], name: "index_classroom_teachers_on_classroom_id", using: :btree
  add_index "classroom_teachers", ["teacher_id"], name: "index_classroom_teachers_on_teacher_id", using: :btree

  create_table "classrooms", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "students_count", default: 0
    t.integer  "tracks_count",   default: 0
    t.string   "teacher_token"
    t.text     "description"
  end

  create_table "invitations", force: true do |t|
    t.integer  "classroom_id"
    t.integer  "student_id"
    t.string   "token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email"
    t.boolean  "help",         default: false
  end

  add_index "invitations", ["classroom_id"], name: "index_invitations_on_classroom_id", using: :btree
  add_index "invitations", ["student_id"], name: "index_invitations_on_student_id", using: :btree
  add_index "invitations", ["token"], name: "index_invitations_on_token", using: :btree

  create_table "ratings", force: true do |t|
    t.integer  "score"
    t.integer  "checkpoint_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "student_id"
  end

  add_index "ratings", ["checkpoint_id"], name: "index_ratings_on_checkpoint_id", using: :btree
  add_index "ratings", ["student_id"], name: "index_ratings_on_student_id", using: :btree

  create_table "students", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teachers", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "tracks", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "classroom_id"
    t.datetime "start_time"
    t.datetime "end_time"
    t.boolean  "published",    default: false
    t.integer  "position"
    t.text     "note"
  end

  add_index "tracks", ["classroom_id"], name: "index_tracks_on_classroom_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "email"
    t.integer  "classrole_id"
    t.string   "classrole_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "password_digest"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "auth_token"
    t.string   "gravatar"
  end

  add_index "users", ["auth_token"], name: "index_users_on_auth_token", using: :btree
  add_index "users", ["classrole_id", "classrole_type"], name: "index_users_on_classrole_id_and_classrole_type", using: :btree

end
