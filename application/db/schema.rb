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

ActiveRecord::Schema[7.1].define(version: 2024_03_28_151236) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bills", force: :cascade do |t|
    t.decimal "invoice_value"
    t.date "due_date"
    t.bigint "enrollment_id", null: false
    t.string "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["enrollment_id"], name: "index_bills_on_enrollment_id"
  end

  create_table "enrollments", force: :cascade do |t|
    t.decimal "total_course_price"
    t.integer "quantity_of_bills"
    t.integer "bill_due_date"
    t.string "course_name"
    t.bigint "institution_id", null: false
    t.bigint "student_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["institution_id"], name: "index_enrollments_on_institution_id"
    t.index ["student_id"], name: "index_enrollments_on_student_id"
  end

  create_table "institutions", force: :cascade do |t|
    t.string "name"
    t.string "cnpj"
    t.string "type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.integer "number"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.string "cep"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.string "cpf"
    t.date "date_of_birth"
    t.integer "phone"
    t.string "gender"
    t.string "payment_method"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "address"
    t.integer "number"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.string "cep"
  end

  add_foreign_key "bills", "enrollments"
  add_foreign_key "enrollments", "institutions"
  add_foreign_key "enrollments", "students"
end
