class Producto < ActiveRecord::Base
  enum pack: [:warehouse, :freshes, :vegetables, :fragile, :cleaning]
  has_and_belongs_to_many :categorias
  belongs_to :supplier
  has_many :transaction_details

  validates :codigo, uniqueness: true
  #validates :supplier, presence: true

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
			prod.supplier ? prod.supplier_id :  1
      prod.save!
    end
    start_time = Time.now
    counter = 0
    data = []
    ActiveRecord::Base.clear_cache!
    CSV.foreach(file.path, {col_sep: "|", :headers=>:first_row, :encoding => 'ISO-8859-1:utf-8'}) do |row|
      # File Columns: 0)código 1)Estado 2)Cod. Proveedor 3)Proveedor
      #               4)Producto 5)Descripcion del producto
      #               6)Precio final 7)Supermercado 8)Stock
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
      prod.stock = row_hash['Stock']
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
              'Descripcion', 'Precio final', 'Precio super', 'Stock']
      all.each do |prod|
        csv << [
          prod.codigo,
          prod.oculto ? 'oculto' : 'activo',
          prod.supplier ? prod.supplier.id : 'sin proveedor',
          prod.supplier ? prod.supplier.name : 'sin nombre proveedor',
          prod.nombre,
          prod.descripcion,
          prod.precio,
          prod.precio_super,
          prod.stock,
        ]
      end
    end
	end

	def self.destacados
		Producto.where("highlight = :destacado", destacado: true).order(:orden)
	end

	def self.bySubcategoria(categoria_id, subcategoria_id)
		Producto.joins(:categorias)
				.where(
						"categorias_productos.categoria_id = :sub_id AND categorias.parent_id = :id",
						id: categoria_id,
						sub_id: subcategoria_id
				)
				.order(:orden, :nombre)
	end

	def self.byCategoria(categoria_id)
		Producto.joins(:categorias)
				.where(
						"categorias.id = :id OR categorias.parent_id = :id",
						id: categoria_id
				)
				.order(:orden, :nombre)
	end

end
