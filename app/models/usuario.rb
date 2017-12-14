class Usuario < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  self.inheritance_column = :_type_disabled
  devise :confirmable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :circulo
  has_many :pedidos
  has_one :account
	has_many :deliveries
	has_many :compras, :through => :deliveries
  has_many :identities

  has_paper_trail

  before_create :set_default_role

  scope :usrs, -> {where('type != "Sistema"')}
  scope :evo_usuarios, -> (date_param) {where('updated_at >= :today', today: date_param)}


  ADMIN = 'Admin'
  COORDINADOR = 'Coordinador'
  USUARIO = 'Usuario'
  SISTEMA = 'Sistema'

  def nombre
    super.nil? ? '' : super
  end

  def apellido
    super.nil? ? '' : super
  end

  def nombre_completo
    "#{apellido}, #{nombre}"
  end

  def self.types
    [ADMIN, COORDINADOR, USUARIO, SISTEMA]
  end

  def admin?
    type == ADMIN
  end

  def coordinador?
    type == COORDINADOR
  end

  def usuario?
    type == USUARIO
  end

  def sistema?
    type == SISTEMA
  end

  def pedido?(ciclo_de_compra)
    ciclo_de_compra && self.pedidos.try(:last).try(:ciclo) == ciclo_de_compra
  end

  def pedido_del_ciclo(ciclo_de_compra)
    return nil if ciclo_de_compra.nil?
    pedido = self.pedidos.where(compra_id: ciclo_de_compra.id).first
    return pedido if pedido
    nil
  end

  def ultimos_pedidos(usuario)
    return nil if usuario.nil?
    pedido = self.pedidos.where(usuario_id: usuario.id).last
    return pedido if pedido
    nil
  end

  def self.new_users_per_month
    count_users = {}
    users_by_month = []
    totals = Usuario
      .select('count(usuarios.id) as users_qty,
      year(usuarios.created_at) as year,
      month(usuarios.created_at) as month')
      .group('year, month')
      .order('year')

    totals.map do |mes|
      unless (count_users[mes.year])
        count_users[mes.year] = {
          label: mes.year,
          backgroundColor: self.colors["#{mes.year}"],
          data: []
        }
      end
      count_users[mes.year][:data].push(mes.users_qty)
    end

    count_users.each do |key, v|
      users_by_month.push(v)
    end

    return users_by_month
  end

  def self.users_totals_per_year
    Usuario
      .select('count(usuarios.id) as total,
      YEAR(usuarios.created_at) as year')
      .group('year')
      .order('year').last(2)
  end


  def self.nuevos_coordinadores()
    coordinadores = Usuario.where("type=? AND circulo_id IS NULL OR circulo_id = ?","Coordinador", '')
    return coordinadores
  end

  def self.to_csv
    CSV.generate do |csv|
      csv << ['Usuario Nro', 'Apellido y Nombre', 'Email', 'Fecha Nac.', 'Teléfono/Celular', 'DNI', 'Domicilio',
              'Circulo Nro', 'Rol', 'Fecha registro', 'Fecha último ingreso', ]
      all.each do |usuario|
        csv << [
          usuario.id,
          "#{usuario.apellido}, #{usuario.nombre}",
          usuario.email,
          usuario.fecha_de_nacimiento || "--",
          "#{usuario.tel1} / #{usuario.cel1}",
          usuario.dni || "--",
          usuario.calle || "--",
          usuario.try('circulo').try('id') || "sin circulo",
          usuario.type || "--",
          usuario.created_at.present? ? usuario.created_at.strftime("%d-%m-%Y") : "--",
          usuario.last_sign_in_at.present? ? usuario.last_sign_in_at.strftime("%d-%m-%Y") : "--"
        ]
      end
    end
	end

	def confirmation_required?
		!confirmed?
  end

  def self.koala(auth)
    access_token = auth.token
    facebook = Koala::Facebook::API.new(access_token)
    facebook.get_object("me?fields=name,picture")
  end

  def self.find_for_oauth(auth, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user

    if user.nil?
      email = auth.info.email
      user = User.find_by(email: email) if email

      # Create the user if it's a new registration
      if user.nil?
        password = Devise.friendly_token[0,20]
        if auth.provider == 'facebook'
          user = User.new(
            email: email ? email : "#{auth.uid}@change-me.com",
            password: password,
            password_confirmation: password
          )
        elsif auth.provider == 'twitter'
          user = User.new(
            email: "#{auth.uid}@change-me.com",
            password: password,
            password_confirmation: password
          )
        end
      end
      user.save!
    end

    if identity.user != user
      identity.user = user
      identity.save!
    end

    user
  end

  def email_verified?
    if self.email
      if self.email.split('@')[1] == 'change-me.com'
        return false
      else
        return true
      end
    else
      return false
    end
  end

	private
  def set_default_role
    self.type ||= Usuario::USUARIO
  end

  def self.colors
    {
      '2015' => 'rgba(155, 89, 182, 0.6)',
      '2016' => 'rgba(46, 204, 113, 0.6)',
      '2017' => 'rgba(192, 57, 43, 0.6)',
      '2018' => 'rgba(44, 62, 80,0.6)'
    }
  end

end
