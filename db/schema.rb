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

ActiveRecord::Schema.define(version: 20181121013849) do

  create_table "accounts", force: :cascade do |t|
    t.integer  "usuario_id", limit: 4
    t.boolean  "status"
    t.float    "balance",    limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ar_internal_metadata", primary_key: "key", force: :cascade do |t|
    t.string   "value",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "bundle_products", force: :cascade do |t|
    t.integer  "producto_id", limit: 4
    t.integer  "item_id",     limit: 4
    t.text     "description", limit: 65535
    t.integer  "qty",         limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categorias", force: :cascade do |t|
    t.string   "nombre",      limit: 255
    t.text     "descripcion", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id",   limit: 4
  end

  add_index "categorias", ["parent_id"], name: "index_categorias_on_parent_id", using: :btree

  create_table "categorias_productos", force: :cascade do |t|
    t.integer "categoria_id", limit: 4
    t.integer "producto_id",  limit: 4
  end

  create_table "circulos", force: :cascade do |t|
    t.integer  "coordinador_id", limit: 4
    t.boolean  "special_type",             default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "warehouse_id",   limit: 4
  end

  create_table "circulos_compras", force: :cascade do |t|
    t.integer  "circulo_id",    limit: 4
    t.integer  "compra_id",     limit: 4
    t.integer  "usuarios_id",   limit: 4
    t.integer  "warehouses_id", limit: 4
    t.integer  "checkpoint",    limit: 4
    t.datetime "delivery_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "circulos_compras", ["usuarios_id"], name: "index_circulos_compras_on_usuarios_id", using: :btree
  add_index "circulos_compras", ["warehouses_id"], name: "index_circulos_compras_on_warehouses_id", using: :btree

  create_table "compras", force: :cascade do |t|
    t.string   "nombre",                limit: 255
    t.text     "descripcion",           limit: 65535
    t.datetime "fecha_inicio_compras"
    t.datetime "fecha_fin_compras"
    t.datetime "fecha_inicio_pagos"
    t.datetime "fecha_inicio_armado"
    t.datetime "fecha_fin_armado"
    t.datetime "fecha_fin_pagos"
    t.datetime "fecha_entrega_compras"
    t.integer  "tipo",                  limit: 4
  end

  create_table "delivery_statuses", force: :cascade do |t|
    t.integer  "delivery_id", limit: 4
    t.integer  "sector_id",   limit: 4
    t.integer  "status_id",   limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identities", force: :cascade do |t|
    t.integer  "usuario_id",    limit: 4
    t.string   "provider",      limit: 255
    t.string   "uid",           limit: 255
    t.string   "token",         limit: 255
    t.string   "secret",        limit: 255
    t.string   "refresh_token", limit: 255
    t.string   "name",          limit: 255
    t.string   "email",         limit: 255
    t.string   "nickname",      limit: 255
    t.string   "image",         limit: 255
    t.string   "phone",         limit: 255
    t.string   "urls",          limit: 255
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "media", force: :cascade do |t|
    t.integer  "owner_id",      limit: 4
    t.string   "file",          limit: 255
    t.string   "resource_type", limit: 255
    t.boolean  "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "packs", force: :cascade do |t|
    t.string   "code",           limit: 255
    t.string   "name",           limit: 255
    t.float    "price",          limit: 24
    t.float    "price_super",    limit: 24
    t.text     "description",    limit: 65535
    t.integer  "id_producto",    limit: 4
    t.integer  "id_supplier",    limit: 4
    t.integer  "amount_allowed", limit: 4
    t.string   "picture",        limit: 255
    t.string   "brand",          limit: 255
    t.boolean  "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pedidos", force: :cascade do |t|
    t.text     "items",          limit: 65535
    t.integer  "usuario_id",     limit: 4
    t.integer  "circulo_id",     limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "compra_id",      limit: 4
    t.float    "total_discount", limit: 24
    t.float    "total",          limit: 24
    t.integer  "total_products", limit: 4
    t.integer  "invoice_number", limit: 4
    t.datetime "invoice_date"
    t.boolean  "active"
    t.float    "saving",         limit: 24
    t.integer  "warehouse_id",   limit: 4
  end

  add_index "pedidos", ["compra_id"], name: "index_pedidos_on_compra_id", using: :btree

  create_table "pedidos_details", force: :cascade do |t|
    t.integer  "pedido_id",      limit: 4
    t.integer  "invoice_id",     limit: 4
    t.integer  "mai_id",         limit: 4
    t.integer  "supplier_id",    limit: 4
    t.string   "supplier_name",  limit: 255
    t.integer  "product_id",     limit: 4
    t.string   "product_codigo", limit: 255
    t.string   "product_name",   limit: 255
    t.integer  "product_qty",    limit: 4
    t.float    "product_price",  limit: 24
    t.float    "total_line",     limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "productos", force: :cascade do |t|
    t.float    "precio",             limit: 24
    t.string   "nombre",             limit: 255
    t.string   "remito_name",        limit: 255
    t.text     "descripcion",        limit: 65535
    t.integer  "cantidad_permitida", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "imagen",             limit: 255
    t.float    "precio_super",       limit: 24
    t.integer  "supplier_id",        limit: 4
    t.string   "codigo",             limit: 255
    t.integer  "sale_type",          limit: 4
    t.integer  "orden",              limit: 4,     default: 0
    t.boolean  "highlight",                        default: false
    t.boolean  "faltante"
    t.integer  "pack",               limit: 4,     default: 0
    t.integer  "stock",              limit: 4
    t.integer  "orden_remito",       limit: 4
    t.text     "costo",              limit: 65535
    t.text     "moneda",             limit: 65535
    t.text     "margen",             limit: 65535
    t.text     "alicuota",           limit: 65535
    t.string   "marca",              limit: 255
    t.integer  "oculto",             limit: 1,     default: 0
    t.integer  "product_type",       limit: 4
  end

  add_index "productos", ["supplier_id"], name: "index_productos_on_supplier_id", using: :btree

  create_table "productos_warehouses", force: :cascade do |t|
    t.integer "producto_id",  limit: 4
    t.integer "warehouse_id", limit: 4
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sectors", force: :cascade do |t|
    t.string   "name",        limit: 255
    t.text     "description", limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seed_migration_data_migrations", force: :cascade do |t|
    t.string   "version",     limit: 255
    t.integer  "runtime",     limit: 4
    t.datetime "migrated_on"
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suppliers", force: :cascade do |t|
    t.string   "name",               limit: 255
    t.string   "address",            limit: 255
    t.integer  "nature",             limit: 4,                              default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "razon_social",       limit: 65535
    t.text     "calle",              limit: 65535
    t.text     "ciudad",             limit: 65535
    t.text     "codigo_postal",      limit: 65535
    t.text     "telefono",           limit: 65535
    t.text     "nombre_contacto",    limit: 65535
    t.text     "email",              limit: 65535
    t.text     "web",                limit: 65535
    t.decimal  "latitude",                         precision: 10, scale: 6
    t.decimal  "longitude",                        precision: 10, scale: 6
    t.text     "error_code",         limit: 65535
    t.text     "description",        limit: 65535
    t.string   "logo",               limit: 255
    t.text     "video",              limit: 65535
    t.boolean  "active",                                                    default: false
    t.text     "operation_type",     limit: 65535
    t.text     "iva_condition",      limit: 65535
    t.text     "identity_type",      limit: 65535
    t.text     "identity_number",    limit: 65535
    t.text     "inscription_number", limit: 65535
  end

  create_table "transaction_details", force: :cascade do |t|
    t.integer  "transaction_id", limit: 4
    t.integer  "producto_id",    limit: 4
    t.float    "price",          limit: 24
    t.integer  "quantity",       limit: 4
    t.float    "subtotal",       limit: 24
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "account_id",       limit: 4
    t.integer  "pedido_id",        limit: 4
    t.integer  "transaction_type", limit: 4
    t.float    "amount",           limit: 24
    t.text     "description",      limit: 65535
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "parent_id",        limit: 4
  end

  add_index "transactions", ["parent_id"], name: "index_transactions_on_parent_id", using: :btree

  create_table "usuario_roles", force: :cascade do |t|
    t.integer  "usuario_id",   limit: 4
    t.integer  "role_id",      limit: 4
    t.integer  "warehouse_id", limit: 4
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usuarios", force: :cascade do |t|
    t.string   "nombre",                 limit: 255
    t.string   "apellido",               limit: 255
    t.date     "fecha_de_nacimiento"
    t.string   "calle",                  limit: 255
    t.string   "codigo_postal",          limit: 255
    t.string   "ciudad",                 limit: 255
    t.string   "pais",                   limit: 255
    t.string   "tel1",                   limit: 255
    t.string   "cel1",                   limit: 255
    t.string   "type",                   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "email",                  limit: 255,   default: "", null: false
    t.string   "encrypted_password",     limit: 255,   default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.integer  "circulo_id",             limit: 4
    t.string   "dni",                    limit: 255
    t.datetime "confirmed_at"
    t.string   "confirmation_token",     limit: 255
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email",      limit: 255
    t.text     "nombre_iva",             limit: 65535
    t.text     "zona",                   limit: 65535
    t.text     "codigo_vendedor",        limit: 65535
    t.text     "tipo_operacion",         limit: 65535
    t.text     "inscripcion_iva",        limit: 65535
    t.text     "tipo_identificacion",    limit: 65535
    t.text     "numero_identificacion",  limit: 65535
    t.text     "numero_ingresos_brutos", limit: 65535
    t.text     "codigo_transporte",      limit: 65535
    t.text     "codigo_clasificacion",   limit: 65535
  end

  add_index "usuarios", ["confirmation_token"], name: "index_usuarios_on_confirmation_token", unique: true, using: :btree
  add_index "usuarios", ["email"], name: "index_usuarios_on_email", unique: true, using: :btree
  add_index "usuarios", ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true, using: :btree

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  limit: 255,   null: false
    t.integer  "item_id",    limit: 4,     null: false
    t.string   "event",      limit: 255,   null: false
    t.string   "whodunnit",  limit: 255
    t.text     "object",     limit: 65535
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id", using: :btree

  create_table "warehouses", force: :cascade do |t|
    t.string   "name",          limit: 255
    t.text     "description",   limit: 65535
    t.string   "address",       limit: 255
    t.string   "telephone",     limit: 255
    t.string   "working_hours", limit: 255
    t.string   "attendant",     limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "warehouses_compras", force: :cascade do |t|
    t.integer "warehouse_id", limit: 4
    t.integer "compra_id",    limit: 4
  end

end
