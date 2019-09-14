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

ActiveRecord::Schema.define(version: 2019_08_31_134921) do

  create_table "accounts", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "usuario_id"
    t.boolean "status"
    t.float "balance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bundle_products", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "producto_id"
    t.integer "item_id"
    t.text "description"
    t.integer "qty"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categorias", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "nombre"
    t.text "descripcion"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "parent_id"
    t.index ["parent_id"], name: "index_categorias_on_parent_id"
  end

  create_table "categorias_productos", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "categoria_id"
    t.integer "producto_id"
  end

  create_table "circulos", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "coordinador_id"
    t.boolean "special_type", default: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "warehouse_id"
  end

  create_table "circulos_compras", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "circulo_id"
    t.integer "compra_id"
    t.integer "usuarios_id"
    t.integer "warehouses_id"
    t.integer "checkpoint"
    t.datetime "delivery_time"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["usuarios_id"], name: "index_circulos_compras_on_usuarios_id"
    t.index ["warehouses_id"], name: "index_circulos_compras_on_warehouses_id"
  end

  create_table "compras", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "nombre"
    t.text "descripcion"
    t.datetime "fecha_inicio_compras"
    t.datetime "fecha_fin_compras"
    t.datetime "fecha_inicio_pagos"
    t.datetime "fecha_inicio_armado"
    t.datetime "fecha_fin_armado"
    t.datetime "fecha_fin_pagos"
    t.datetime "fecha_entrega_compras"
    t.integer "tipo"
  end

  create_table "delivery_statuses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "delivery_id"
    t.integer "sector_id"
    t.integer "status_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "identities", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "usuario_id"
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.string "secret"
    t.string "refresh_token"
    t.string "name"
    t.string "email"
    t.string "nickname"
    t.string "image"
    t.string "phone"
    t.string "urls"
    t.datetime "expires_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "media", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "owner_id"
    t.string "file"
    t.string "resource_type"
    t.boolean "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pedidos", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.text "items"
    t.integer "usuario_id"
    t.integer "circulo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "compra_id"
    t.float "total_discount"
    t.float "total"
    t.integer "total_products"
    t.integer "invoice_number"
    t.datetime "invoice_date"
    t.boolean "active"
    t.float "saving"
    t.integer "warehouse_id"
    t.index ["compra_id"], name: "index_pedidos_on_compra_id"
  end

  create_table "pedidos_details", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "pedido_id"
    t.integer "invoice_id"
    t.integer "mai_id"
    t.integer "supplier_id"
    t.string "supplier_name"
    t.integer "product_id"
    t.string "product_codigo"
    t.string "product_name"
    t.integer "product_qty"
    t.float "product_price"
    t.float "total_line"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "productos", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.float "precio"
    t.string "nombre"
    t.string "remito_name"
    t.text "descripcion"
    t.integer "cantidad_permitida"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "imagen"
    t.float "precio_super"
    t.integer "supplier_id"
    t.string "codigo"
    t.boolean "oculto", default: false
    t.boolean "wholesale", default: false
    t.integer "sale_type"
    t.integer "orden", default: 0
    t.boolean "highlight", default: false
    t.boolean "faltante"
    t.integer "pack", default: 0
    t.integer "stock"
    t.string "orden_remito"
    t.text "costo"
    t.text "moneda"
    t.text "margen"
    t.text "alicuota"
    t.string "marca"
    t.integer "product_type"
    t.index ["supplier_id"], name: "index_productos_on_supplier_id"
  end

  create_table "productos_warehouses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "producto_id"
    t.integer "warehouse_id"
  end

  create_table "roles", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sectors", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "seed_migration_data_migrations", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "version"
    t.integer "runtime"
    t.datetime "migrated_on"
  end

  create_table "statuses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "suppliers", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.integer "nature", default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text "razon_social"
    t.text "calle"
    t.text "ciudad"
    t.text "codigo_postal"
    t.text "telefono"
    t.text "nombre_contacto"
    t.text "email"
    t.text "web"
    t.decimal "latitude", precision: 10, scale: 6
    t.decimal "longitude", precision: 10, scale: 6
    t.text "error_code"
    t.text "description"
    t.string "logo"
    t.text "video"
    t.boolean "active", default: false
    t.text "operation_type"
    t.text "iva_condition"
    t.text "identity_type"
    t.text "identity_number"
    t.text "inscription_number"
  end

  create_table "transaction_details", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "transaction_id"
    t.integer "producto_id"
    t.float "price"
    t.integer "quantity"
    t.float "subtotal"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transactions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.integer "account_id"
    t.integer "pedido_id"
    t.integer "transaction_type"
    t.float "amount"
    t.text "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer "parent_id"
    t.index ["parent_id"], name: "index_transactions_on_parent_id"
  end

  create_table "usuario_roles", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "usuario_id"
    t.integer "role_id"
    t.integer "warehouse_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "usuarios", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "nombre"
    t.string "apellido"
    t.date "fecha_de_nacimiento"
    t.string "calle"
    t.string "codigo_postal"
    t.string "ciudad"
    t.string "pais"
    t.string "tel1"
    t.string "cel1"
    t.string "type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.integer "circulo_id"
    t.string "dni"
    t.datetime "confirmed_at"
    t.string "confirmation_token"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "confirmed_circle_at"
    t.string "confirmation_token_circle"
    t.datetime "confirmation_circle_sent_at"
    t.string "unconfirmed_circle"
    t.text "nombre_iva"
    t.text "zona"
    t.text "codigo_vendedor"
    t.text "tipo_operacion"
    t.text "inscripcion_iva"
    t.text "tipo_identificacion"
    t.text "numero_identificacion"
    t.text "numero_ingresos_brutos"
    t.text "codigo_transporte"
    t.text "codigo_clasificacion"
    t.integer "warehouse_id"
    t.index ["confirmation_token"], name: "index_usuarios_on_confirmation_token", unique: true
    t.index ["confirmation_token_circle"], name: "index_usuarios_on_confirmation_token_circle", unique: true
    t.index ["email"], name: "index_usuarios_on_email", unique: true
    t.index ["reset_password_token"], name: "index_usuarios_on_reset_password_token", unique: true
  end

  create_table "versions", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci", force: :cascade do |t|
    t.string "item_type", null: false
    t.integer "item_id", null: false
    t.string "event", null: false
    t.string "whodunnit"
    t.text "object"
    t.datetime "created_at"
    t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
  end

  create_table "warehouses", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "address"
    t.string "telephone"
    t.string "working_hours"
    t.string "attendant"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "warehouses_compras", id: :integer, options: "ENGINE=InnoDB DEFAULT CHARSET=latin1", force: :cascade do |t|
    t.integer "warehouse_id"
    t.integer "compra_id"
  end

end
