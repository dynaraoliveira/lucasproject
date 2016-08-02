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

ActiveRecord::Schema.define(version: 20160801041642) do

  create_table "equipaments", force: :cascade do |t|
    t.string   "chave"
    t.string   "nome"
    t.string   "cidade"
    t.string   "estado"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["chave"], name: "index_equipaments_on_chave", unique: true
  end

  create_table "equipamentusers", force: :cascade do |t|
    t.integer  "equipament_id"
    t.integer  "user_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["equipament_id"], name: "index_equipamentusers_on_equipament_id"
    t.index ["user_id"], name: "index_equipamentusers_on_user_id"
  end

  create_table "sensors", force: :cascade do |t|
    t.string   "chave"
    t.integer  "sensor0"
    t.integer  "sensor1"
    t.integer  "sensor2"
    t.integer  "sensor3"
    t.integer  "sensor4"
    t.integer  "sensor5"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.datetime "datainclusao"
    t.integer  "equipament_id"
    t.index ["equipament_id"], name: "index_sensors_on_equipament_id", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "usertype"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

end
