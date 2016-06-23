class Producto < ActiveRecord::Base
  enum pack: [:warehouse, :freshes, :vegetables, :fragile, :cleaning]
  has_and_belongs_to_many :categorias
  belongs_to :supplier
  has_many :transaction_details

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

  def grupo_remito
    grupo = ''
    puts(self.codigo.from(0).to(2))
    case self.codigo.from(0).to(2)
      when 'ALM'
        grupo = "Almacen"
      when 'LIM', 'HIP'
        grupo = "Limpieza"
      when 'FYV'
        grupo = "Fruta y Verdura"
      when 'FRE'
        grupo = "Frescos"
      else
        grupo = 'Otros'
    end
    return grupo
  end

  def ahorro
    return 0 if precio_super.nil? || precio_super == 0 || precio_super < precio
    100 * (precio_super - precio) / precio_super
  end

  def populate!(params)
    imagen = params[:imagen]
    categorias = Categoria.find(params[:categorias].select {|k,v| v == "1"}.keys)
  end

  def self.import(file)
    all.each do |prod|
      prod.oculto = true
      prod.faltante = false
      prod.save!
    end
    start_time = Time.now
    counter = 0
    data = []
    ActiveRecord::Base.clear_cache!
    CSV.foreach(file.path, {col_sep: ',', :headers=>:first_row, :encoding => 'UTF-8,ISO-8859-1'}) do |row|
      # File Columns: 0)código 1)Estado 2)Cod. Proveedor 3)Proveedor
      #               4)Producto 5)Descripcion del producto
      #               6)Precio final 7)Supermercado
      row_hash = row.to_hash
      prod = Producto.find_or_create_by(codigo: row_hash['Codigo'].upcase)
      prod.oculto = false if row_hash['Estado'] == 'activo'
      supplier = Supplier.find_by_id(row_hash['Cod. Proveedor'])
      if supplier.present?
        prod.supplier_id= supplier.id
      else
        prod.supplier_id =  1
      end
      prod.nombre = row_hash['Nombre']
      prod.descripcion = row_hash['Descripcion']
      prod.precio = row_hash['Precio final'].to_s.to_s.gsub(',', '.').to_f
      prod.precio_super = row_hash['Precio super'].to_s.gsub(',', '.').to_f
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
    CSV.generate(force_quotes: true, encoding: 'utf-8', col_sep:'|') do |csv|
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
