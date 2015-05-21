# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


categorias = ['Canasta', 'Almacen', 'Frescos', 'Verduras', 'Higiene Personal', 'Limpieza']

categorias.each do |c|
  Categoria.create!(nombre: c)
end

proveedor = Supplier.create!(name: 'Generico', nature: :wholesaler)
categoria_id = 1
categoria = Categoria.find_by_id(categoria_id)
productos = []

JSON.parse(open("db/products.json").read).each do |p|
  JSON.parse(open("db/products_description.json").read).each do |pd|
    if p['products_id'] == pd['products_id']
      
      p = { codigo: p['products_id'],
            nombre: pd['products_name'],
            descripcion: pd['products_description'],
            precio: p['products_price'], 
            precio_super: 0,
          }
          
      if Rails.env.production?
        img_dir = '/home/deploy/mision/shared/tmp/imagenes/'
        image = File.open("#{img_dir}img_no_disponible.png")
        image_path = "#{img_dir}#{p['products_image']}"
        image = File.open(image_path) if File.owned?(image_path)
        p[:imagen] = image
      end

      prod = Producto.new(p)
      prod.categorias << categoria
      prod.supplier = proveedor
      prod.save!
    end
  end
end

usuarios = [
  { nombre: 'admin', password: '!QAZzaq1', email: 'admin@example.com', type: 'Admin' },
  { nombre: 'coordinador', password: '!QAZzaq1', email: 'coordinador@example.com', type: 'Coordinador' },
  { nombre: 'usuario', password: '!QAZzaq1', email: 'usuario@example.com', type: 'Usuario' },
  { nombre: 'nicolas', password: '!QAZzaq1', email: 'nicolas@example.com', type: 'Usuario' },
  { nombre: 'daniel', password: '!QAZzaq1', email: 'daniel@example.com', type: 'Usuario' },
  { nombre: 'andres', password: '!QAZzaq1', email: 'andres@example.com', type: 'Usuario' },
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
