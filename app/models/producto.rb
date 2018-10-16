class Producto < ActiveRecord::Base
  enum pack: [:wholesaler, :freshes, :vegetables, :fragile, :cleaning]
  has_and_belongs_to_many :categorias
  belongs_to :supplier
  has_many :transaction_details
  has_many :bundle_products
  has_many :roles, :through => :usuario_roles
  has_and_belongs_to_many :categorias


  accepts_nested_attributes_for :bundle_products


  validates :codigo, uniqueness: true
  #validates :supplier, presence: true

  mount_uploader :imagen, ImagenUploader

  has_paper_trail

  scope :disponibles, -> { where(oculto: false) }
	scope :destacados, -> {where(highlight: true, oculto: false)}
	scope :offers, -> {joins(:suppliers).where(highlight: true, oculto: false, nature: 1).order("RAND()").limit(3)}
  scope :ocultos, -> {where(oculto: true)}
  scope :stock, -> {where('stock != 0 OR stock IS NULL')}
  scope :freesale, -> {where('sale_type = :free and oculto = :oculto' , free: 1, oculto: false)}
	scope :categoria, lambda { |categoria| joins(:categorias).where('categorias.id = :id OR categorias.parent_id = :id',
			id: categoria).order(:orden, :nombre) if categoria }
	scope :subcategoria, lambda { |categoria, subcategoria| joins(:categorias)
																															.where('categorias_productos.categoria_id = :sub_id AND categorias.parent_id = :id', id: categoria, sub_id: subcategoria)
																															.order(:orden, :nombre) if categoria && subcategoria }
  scope :supplier, -> (supplier_id) {where('supplier_id = ?', supplier_id)}
  scope :evo_products, -> (date_param) {where('updated_at >= :today', today: date_param)}


  after_initialize :default_cantidad_permitida

  def default_cantidad_permitida
    self.cantidad_permitida ||= 10
  end

  def self.build
    producto = self.new
    producto.bundle_products.build
    producto
  end

  def cart_action(session)
    if session[:product_ids ].include?(self.id)
      'Remove from'
    else
      'Add to'
    end
  end

  def ahorro
    return 0 if precio_super.nil? || precio_super == 0 || precio_super < precio || precio.nil?
    100 * (precio_super - precio) / precio_super
  end

  def populate!(params)
    imagen = params[:imagen]
    categorias = Categoria.find(params[:categorias].select {|k,v| v == "1"}.keys)
  end

  def cantidad
    return self.stock if self.stock.present? and self.cantidad_permitida > self.stock
    self.cantidad_permitida
  end

  def precio_super_show
    if self.precio_super.present?
      return 0.0 if self.precio > self.precio_super
        precio_super = self.precio_super
    else
      0.0
    end
  end

  def get_related_products(categoria)
    #get random products
    Producto.joins(:categorias).where('productos.oculto = false AND categorias.id = :id OR categorias.parent_id = :id ',
                             id: categoria).order("RAND()").limit(3) if categoria
  end

  def self.get_offers_products
    #get random products
    Producto.joins(:supplier).where('productos.oculto = false AND suppliers.nature = :id',
                                      id: 1).order("RAND()").limit(8)
  end

  def self.search(term)
    where('LOWER(nombre) LIKE :term OR LOWER(descripcion) LIKE :term OR  LOWER(codigo) LIKE :term', term: "%#{term.downcase}%")
  end

  def bundle_products_for_form
    collection = bundle_products.where(item_id: id)
    collection.any? ? collection : bundle_products.build
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
      #               4)Producto 5)Descripcion del producto 6)Marca
      #               7)Precio final 8)Supermercado 9)Stock
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
      prod.marca = row_hash['Marca']
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
              'Descripcion', 'Marca', 'Precio final', 'Precio super', 'Stock']
      all.each do |prod|
        csv << [
          prod.codigo,
          prod.oculto ? 'oculto' : 'activo',
          prod.supplier ? prod.supplier.id : 'sin proveedor',
          prod.supplier ? prod.supplier.name : 'sin nombre proveedor',
          prod.nombre,
          prod.descripcion,
          prod.marca,
          prod.precio,
          prod.precio_super,
          prod.stock,
        ]
      end
    end
  end

end
