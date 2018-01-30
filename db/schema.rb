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

ActiveRecord::Schema.define(version: 20180128013930) do

  create_table "admissions", force: :cascade do |t|
    t.string "petitioner_name"
    t.string "petitioner_phone"
    t.string "petitioner_email"
    t.string "patient_name"
    t.integer "species"
    t.integer "sex"
    t.string "breed"
    t.string "owner_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "completed"
    t.text "comments"
    t.integer "veterinarian_id"
    t.integer "veterinary_id"
    t.string "age"
    t.string "exams"
    t.index ["veterinarian_id"], name: "index_admissions_on_veterinarian_id"
    t.index ["veterinary_id"], name: "index_admissions_on_veterinary_id"
  end

  create_table "employments", force: :cascade do |t|
    t.integer "veterinary_id"
    t.integer "veterinarian_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["veterinarian_id"], name: "index_employments_on_veterinarian_id"
    t.index ["veterinary_id"], name: "index_employments_on_veterinary_id"
  end

  create_table "veterinarians", force: :cascade do |t|
    t.string "full_name"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "veterinaries", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
