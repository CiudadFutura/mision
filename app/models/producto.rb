class Producto < ActiveRecord::Base
  has_and_belongs_to_many :categorias
  belongs_to :supplier

  validates :codigo, uniqueness: true
  validates :supplier, presence: true

  mount_uploader :imagen, ImagenUploader

  has_paper_trail

  scope :disponibles, -> { where(oculto: false) }

  after_initialize :default_cantidad_permitida

  def default_cantidad_permitida
    self.cantidad_permitida ||= 10
  end

  def cart_action(session)
    if session[:product_ids ].include?(self.id)
      'Remove from'
    else
      'Add to'
    end
  end

  def ahorro
    return 0 if precio_super.nil? || precio_super == 0
    100 * (precio_super - precio) / precio_super
  end

  def populate!(params)
    imagen = params[:imagen]
    categorias = Categoria.find(params[:categorias].select {|k,v| v == "1"}.keys)
  end

  def self.import(file)
    all.each do |prod|
      prod.oculto = true
      prod.codigo = prod.codigo.upcase
      prod.save!
    end
    start_time = Time.now
    counter = 0
    data = []

    CSV.foreach(file.path, {col_sep: ";", :headers=>:first_row}) do |row|
      # File Columns: 0)código 1)Estado 2)Cod. Proveedor 3)Proveedor
      #               4)Producto 5)Descripcion del producto
      #               6)Precio final 7)Supermercado
      row_hash = row.to_hash
      prod = Producto.find_or_create_by(codigo: row[0].upcase)
      prod.oculto = false if row[1] == 'activo'
      if Supplier.where(id: row[2]).nil?
        prod.supplier = Supplier.find(row[2])
      else
        prod.supplier =  Supplier.find(1)
      end
      prod.nombre = row[4]
      prod.descripcion = row[5]
      prod.precio = row[6]
      prod.precio_super = row[7]
      prod.save!
      data << [codigo = prod.codigo,
              nombre = prod.nombre,
              ]
      counter += 1
    end
    end_time = Time.now
    return [
        :success => true,
        :message => "#{counter} Productos actualizados #{((end_time - start_time) / 60).round(2)} minutos (#{( counter / (end_time - start_time)).round(2)} productos/segundo)"
    ]
  end

  def self.to_csv
    CSV.generate(force_quotes: true, encoding: 'utf-8') do |csv|
      csv << ['Codigo', 'Estado', 'Cod. Proveedor', 'Proveedor', 'Nombre',
              'Descripcion', 'Precio final', 'Precio super']
      all.each do |prod|
        csv << [
          prod.codigo,
          prod.oculto ? 'oculto' : 'activo',
          prod.supplier.id,
          prod.supplier.name,
          prod.nombre,
          prod.descripcion,
          prod.precio,
          prod.precio_super,
        ]
      end
    end
  end

end
