# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

categorias = {}
JSON.parse(open("db/json/categories.json").read).each do |cat|
  p cat
  if !cat['parent_id'].nil?
    categorias[cat['categories_id']] = { parent_id: cat['parent_id'] }
  end
end

JSON.parse(open("db/json/categories_description.json").read).each do |cat|
  p cat
  if !cat['categories_name'].nil? && !cat['categories_name'].empty?
    categorias[cat['categories_id']][:nombre] = cat['categories_name']
  end
end

categorias_productos = {}
JSON.parse(open("db/json/products_to_categories.json").read).each do |cat_prod|
  if !cat_prod['products_id'].nil? && !cat_prod['categories_id'].nil?
    categorias_productos[cat_prod['products_id']] ||= []
    categorias_productos[cat_prod['products_id']] << cat_prod['categories_id'] if categorias.key?(cat_prod['categories_id'])
  end
end

categorias.each do |id, ca|
  cat = Categoria.new
  cat.id = id
  cat.nombre = ca[:nombre]
  cat.parent_id = ca[:parent_id]
  cat.save!
end

proveedor = Supplier.create!(name: 'Generico', nature: :wholesaler)
productos = []
img_dir = '/home/deploy/mision/shared/tmp/imagenes/'

JSON.parse(open("db/json/products.json").read).each do |prod|
  JSON.parse(open("db/json/products_description.json").read).each do |prod_d|
    if prod['products_id'] == prod_d['products_id'] && Producto.where(codigo: prod['products_model']).empty?

      product = Producto.new
      product.id = prod['products_id']
      product.codigo = prod['products_model']
      product.nombre = prod_d['products_name']
      product.descripcion = prod_d['products_description']
      product.precio = prod['products_price']
      product.precio_super = 0

      if Rails.env.production? && !prod['products_image'].nil? && !prod['products_image'].empty?
        image = File.open("#{img_dir}img_no_disponible.png")
        
        image_path = "#{img_dir}#{prod['products_image']}"
        if File.owned?(image_path)
          image = File.open(image_path) 
        end
        product.imagen = image
      end

      product.categorias << Categoria.find(categorias_productos[prod['products_id']])
      product.supplier = proveedor
      product.save!
    end
  end
end

usuarios = [
  { nombre: 'admin', password: '!QAZzaq1', email: 'admin@example.com', type: 'Admin' },
  { nombre: 'coordinador', password: '!QAZzaq1', email: 'coordinador@example.com', type: 'Coordinador' },
  { nombre: 'usuario', password: '!QAZzaq1', email: 'usuario@example.com', type: 'Usuario' },
  { nombre: 'nicolas', password: '!QAZzaq1', email: 'nicofheredia@gmail.com', type: 'Usuario' },
  { nombre: 'daniel', password: '!QAZzaq1', email: 'daniel@example.com', type: 'Usuario' },
  { nombre: 'andres', password: '!QAZzaq1', email: 'andres.cachero@gmail.com', type: 'Usuario' },
  { nombre: 'diego', password: '!QAZzaq1', email: 'diego@example.com', type: 'Usuario' },
]

usuarios.each do |u|
  user = Usuario.new(u)
  user.save!(validate: false)
end

compras = [
    { nombre: 'Abril', descripcion: '!QAZzaq1', fecha_inicio_compras: DateTime.new(2015,04,01), fecha_fin_compras: DateTime.new(2015,04,01), fecha_fin_pagos: DateTime.new(2015,04,01), fecha_entrega_compras:DateTime.new(2015,04,01) },
    { nombre: 'Mayo', descripcion: '!QAZzaq1', fecha_inicio_compras: DateTime.new(2015,05,01), fecha_fin_compras: DateTime.new(2015,05,01), fecha_fin_pagos: DateTime.new(2015,05,01), fecha_entrega_compras: DateTime.new(2015,05,01) },
    { nombre: 'Junio', descripcion: '!QAZzaq1', fecha_inicio_compras: DateTime.new(2015,06,01), fecha_fin_compras: DateTime.new(2015,06,01), fecha_fin_pagos: DateTime.new(2015,06,01), fecha_entrega_compras:DateTime.new(2015,06,01) }
]

compras.each do |c|
  compra = Compra.new(c)
  compra.save!(validate: false)
end

circulo = Circulo.create!(coordinador_id: Usuario.find_by_nombre('coordinador').id)
usuario = Usuario.find_by_nombre('usuario')
usuario.circulo = circulo
usuario.save!

usuario = Usuario.find_by_nombre('coordinador')
usuario.circulo = circulo
usuario.save!
