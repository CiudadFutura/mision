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

productos = [
  { categoria_id: 1, nombre: 'Canasta Frutas y Verduras Chica', descripcion: 'Tomate 1 kg; Zanahoria 1/2 kg; Papa 1 kg; Cebolla 1 kg; Pimiento 1/2 kg; Banana 1 kg; Calabaza 1; Lechuga Paquete; Acelga  Bandeja 1kg; Naranja  1 kg; Huevo Media docena.',  precio: '70', precio_super: '74' },
  { categoria_id: 1, nombre: 'Canasta frutas y verduras Grande', descripcion: '  Tomate 1 kg; Zanahoria 1/2 kg; Papa 1 kg; Batata 1 kg; Cebolla 1 kg; Pimiento 1/2 kg; Mandarina 1kg; Limon 1/2 kg; Ajo 1; Manzana 1 kg; Banana 1 kg; Calabaza 1; Lechuga Paquete; Cebolla de verdeo Paquete; Puerro Paquete; Rucula Paquete; Repollo Paquete; Brocoli Bandeja; Coliflor Bandeja; Espinaca Paquete; Radicheta Paquete; Remolacha Paquete; Acelga  Bandeja 1kg; Naranja  1 kg; Huevo Media docena.',  precio: 150, precio_super: 150 },
  { categoria_id: 4, nombre: 'Ensaladas Mixta (Radicheta y zanahoria)', descripcion: 'Naturalísima Bandeja 300 g',  precio: 8.4, precio_super: 9 }, 
  { categoria_id: 4, nombre: 'Bandeja espinaca  Naturalísima', descripcion: 'Bandeja 500 g.', precio: 6.3, precio_super: 7 },
  { categoria_id: 4, nombre: 'Verduras para sopa SOPITAS  Naturalísima', descripcion: ' Bandeja 500 g.', precio: 15,    precio_super: 17 },
  { categoria_id: 4, nombre: 'Rúcula hojas  Naturalísima', descripcion: ' Bandeja 200 g.', precio: 6.3, precio_super: 7 },
  { categoria_id: 4, nombre: 'Zanahoria rallada Naturalísima', descripcion: ' Bandeja 350grs 14.7',    precio: 10, precio_super: 20 },
  { categoria_id: 4, nombre: 'Ensaladas de Zanahoria, lechuga, cherri Naturalísima', descripcion: ' Bandeja 350grs', precio: 14.7, precio_super: 15 },
  { categoria_id: 2, nombre: 'Huevos 100% Orgánicos', descripcion: ' Gallinas libres 1/2 docena', precio: 10,    precio_super: 18 },
  { categoria_id: 3, nombre: 'Canasta Frescos',  descripcion: '2 Paquetes Tapas de empanada Mil hojas  x 12, 2 Paquetes Tapas de tarta Mil hojas ; Ravioles Mil hojas 1 kg; Fideos Frescos 1/2 kg ; Muzzarela La Resistencia 500g; Manteca 200gr La Cabaña/Inty ; Crema 360gr La Cabaña/Inty .', precio: 133, precio_super: 150 },
  { categoria_id: 3, nombre: 'Reggianito', descripcion: '  La Resistencia 250g.', precio: 25, precio_super: 29 },
  { categoria_id: 3, nombre: 'Quesos Saborizados La Resistencia', descripcion: ' Pimienta ahumada 350gr', precio: 35.7, precio_super: 34 }, 
  { categoria_id: 5, nombre: 'Shampoo Prunelle 930 cc', descripcion: '', precio: 10.2, precio_super: 18 },
  { categoria_id: 5, nombre: 'Acondicionador  Prunelle 930 cc', descripcion: '', precio: 10.2, precio_super: 17 },
  { categoria_id: 5, nombre: 'Shampoo Tresemmé 400 ml', descripcion: '', precio: 29.7, precio_super: 35 },
  { categoria_id: 6, nombre: 'Jabón líquido Ariel 800 cc', descripcion: '', precio: 25.2, precio_super: 27 },
  { categoria_id: 6, nombre: 'Jabón líquido Libertador 700 cc', descripcion: '', precio: 15.3, precio_super: 17 },
  { categoria_id: 6, nombre: 'Jabón en polvo  Drive 800gr', descripcion: '', precio: 13.2, precio_super: 16 }
]

productos.each do |p|
  categoria_id = p[:categoria_id]
  prod = Producto.create!(p.with_indifferent_access.except(:categoria_id))
  prod.categorias << Categoria.find_by_id(categoria_id)
  prod.save!
end

usuarios = [
  { nombre: 'admin', password: '!QAZzaq1', email: 'email-admin@bla.com', type: 'Admin' },
  { nombre: 'coordinador', password: '!QAZzaq1', email: 'email-coord@bla.com', type: 'Coordinador' },
  { nombre: 'usuario', password: '!QAZzaq1', email: 'email-usuruario@bla.com', type: 'Usuario' }
]

usuarios.each do |u|
  user = Usuario.new(u)
  user.save!(validate: false)
end

circulo = Circulo.create!(coordinador_id: Usuario.find_by_nombre('coordinador').id)
usuario = Usuario.find_by_nombre('usuario')
usuario.circulo = circulo
usuario.save!
