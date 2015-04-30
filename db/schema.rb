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

ActiveRecord::Schema.define(version: 20150403203438) do

  create_table "categorias", force: true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categorias_productos", force: true do |t|
    t.integer "categoria_id"
    t.integer "producto_id"
  end

  create_table "circulos", force: true do |t|
    t.integer  "coordinador_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "compras", force: true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "fecha_inicio_compras"
    t.datetime "fecha_fin_compras"
    t.datetime "fecha_fin_pagos"
    t.datetime "fecha_entrega_compras"
  end

  create_table "pedidos", force: true do |t|
    t.text     "items"
    t.integer  "usuario_id"
    t.integer  "circulo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "productos", force: true do |t|
    t.float    "precio"
    t.string   "nombre"
    t.text     "descripcion"
    t.integer  "cantidad_permitida"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "imagen"
    t.float    "precio_super"
    t.integer  "supplier_id"
  end

  add_index "productos", ["supplier_id"], name: "index_productos_on_supplier_id"

  create_table "suppliers", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "nature",     default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usuarios", force: true do |t|
    t.string   "nombre"
    t.string   "apellido"
    t.date     "fecha_de_nacimiento"
    t.string   "calle"
    t.string   "codigo_postal"
    t.string   "ciudad"
    t.string   "pais"
    t.string   "tel1"
    t.string   "cel1"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.integer  "circulo_id"
    t.string   "dni"
  end

  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true

end
