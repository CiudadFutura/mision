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

ActiveRecord::Schema.define(version: 20160923032011) do

  create_table "accounts", force: true do |t|
    t.integer  "usuario_id"
    t.boolean  "status"
    t.float    "balance",    limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categorias", force: true do |t|
    t.string   "nombre"
    t.text     "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
  end

  add_index "categorias", ["parent_id"], name: "index_categorias_on_parent_id", using: :btree

  create_table "categorias_productos", force: true do |t|
    t.integer "categoria_id"
    t.integer "producto_id"
  end

  create_table "circulos", force: true do |t|
    t.integer  "coordinador_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "circulos_compras", force: true do |t|
    t.integer  "circulo_id"
    t.integer  "compra_id"
    t.integer  "status_id"
    t.integer  "checkpoint"
    t.datetime "delivery_time"
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

  create_table "delivery_statuses", force: true do |t|
    t.integer  "delivery_id"
    t.integer  "sector_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "status_id"
  end

  create_table "pedidos", force: true do |t|
    t.text     "items"
    t.integer  "usuario_id"
    t.integer  "circulo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "compra_id"
  end

  add_index "pedidos", ["compra_id"], name: "index_pedidos_on_compra_id", using: :btree

  create_table "productos", force: true do |t|
    t.float    "precio",             limit: 24
    t.string   "nombre"
    t.text     "descripcion"
    t.integer  "cantidad_permitida"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "imagen"
    t.float    "precio_super",       limit: 24
    t.integer  "supplier_id"
    t.string   "codigo"
    t.boolean  "oculto",                        default: false
    t.integer  "orden",                         default: 0
    t.boolean  "highlight",                     default: false
    t.boolean  "faltante"
    t.integer  "pack",                          default: 0
    t.integer  "stock"
    t.integer  "orden_remito"
  end

  add_index "productos", ["supplier_id"], name: "index_productos_on_supplier_id", using: :btree

  create_table "sectors", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seed_migration_data_migrations", force: true do |t|
    t.string   "version"
    t.integer  "runtime"
    t.datetime "migrated_on"
  end

  create_table "statuses", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suppliers", force: true do |t|
    t.string   "name"
    t.string   "address"
    t.integer  "nature",                                   default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "razon_social"
    t.text     "calle"
    t.text     "ciudad"
    t.text     "codigo_postal"
    t.text     "telefono"
    t.text     "nombre_contacto"
    t.text     "email"
    t.text     "web"
    t.decimal  "latitude",        precision: 10, scale: 6
    t.decimal  "longitude",       precision: 10, scale: 6
    t.text     "error_code"
    t.text     "description"
  end

  create_table "transaction_details", force: true do |t|
    t.integer  "transaction_id"
    t.integer  "producto_id"
    t.float    "price",          limit: 24
    t.integer  "quantity"
    t.float    "subtotal",       limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: true do |t|
    t.integer  "account_id"
    t.integer  "pedido_id"
    t.integer  "transaction_type"
    t.float    "amount",           limit: 24
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id"
  end

  add_index "transactions", ["parent_id"], name: "index_transactions_on_parent_id", using: :btree

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
    t.datetime "confirmed_at"
    t.string   "confirmation_token"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
  end

  add_index "usuarios", ["confirmation_token"], name: "index_usuarios_on_confirmation_token", unique: true, using: :btree
  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true, using: :btree
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: true do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

end
