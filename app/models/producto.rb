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
      puts row.inspect
      puts row_hash["Codigo"]
      prod = Producto.find_or_create_by(codigo: row_hash["Codigo"].upcase)
      puts row_hash["Estado"]
      prod.oculto = false if row_hash["Estado"] == 'activo'
      puts row_hash["Cod Proveedor"]
      if Supplier.where(id: row_hash["Cod. Proveedor"]).nil?
        prod.supplier = Supplier.find(row_hash["Cod. Proveedor"])
      else
        prod.supplier =  Supplier.find(1)
      end
      puts row_hash["Nombre"]
      prod.nombre = row_hash["Nombre"]
      puts row_hash["Descripcion"]
      prod.descripcion = row_hash["Descripcion"]
      puts row_hash["Precio final"]
      prod.precio = row_hash["Precio final"]
      puts row_hash["Precio super"]
      prod.precio_super = row_hash["Precio super"]
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
