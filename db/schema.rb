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

ActiveRecord::Schema[7.2].define(version: 2024_09_13_171540) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alumnos", force: :cascade do |t|
    t.string "nombre"
    t.bigint "colegio_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["colegio_id"], name: "index_alumnos_on_colegio_id"
  end

  create_table "colegios", force: :cascade do |t|
    t.string "nombre"
    t.string "direccion"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "materias", force: :cascade do |t|
    t.string "nombre"
    t.bigint "profesor_id", null: false
    t.bigint "colegio_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["colegio_id"], name: "index_materias_on_colegio_id"
    t.index ["profesor_id"], name: "index_materias_on_profesor_id"
  end

  create_table "notas", force: :cascade do |t|
    t.float "nota"
    t.bigint "alumno_id", null: false
    t.bigint "materia_id", null: false
    t.bigint "colegio_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alumno_id"], name: "index_notas_on_alumno_id"
    t.index ["colegio_id"], name: "index_notas_on_colegio_id"
    t.index ["materia_id"], name: "index_notas_on_materia_id"
  end

  create_table "profesores", force: :cascade do |t|
    t.string "nombre"
    t.bigint "colegio_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["colegio_id"], name: "index_profesores_on_colegio_id"
  end

  add_foreign_key "alumnos", "colegios"
  add_foreign_key "materias", "colegios"
  add_foreign_key "materias", "profesores"
  add_foreign_key "notas", "alumnos"
  add_foreign_key "notas", "colegios"
  add_foreign_key "notas", "materias"
  add_foreign_key "profesores", "colegios"
end
