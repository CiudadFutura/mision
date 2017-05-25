Rails.application.routes.draw do

  resources :sectors_statuses
  resources :statuses
  resources :sectors
  resources :delivery_statuses
  resources :deliveries
  resources :transaction_details
  resources :transactions
  resources :accounts
  resources :compras do
		post :send_email, on: :member
	end
	resources :remitos_pedido
	resources :warehouses

	get 'get_by_cycle_circle/:id/circulo=:circulo',
			to: 'remitos_pedido#get_by_cycle_circle', as: :get_by_cycle_circle

	get 'remitos_pedidos/generate', to: 'remitos_pedido#generate', as: :generate

	get '/transaction/generar/:ciclo_id' => 'transactions#generar', as: :transaction_generar

  resources :suppliers

  get 'compras/add_status/:id', to: 'compras#add_status', as: :add_status
  get 'compras/refresh_status/:id', to: 'compras#refresh_status', as: :refresh_status
  get 'compras/clone/:id', to: 'compras#clone', as: :clone


  resources :circulos do
    post 'add_usuario', to: 'circulos#add_usuario', as: :add_usuario
    delete 'remove_usuario/:usuario_id', to: 'circulos#remove_usuario', as: :remove_usuario
    post 'abandonar', to: 'circulos#abandonar', as: :abandonar
	end
	get 'circulos/remito_circulo/:circulo_id/compra=:compra_id', to: 'circulos#remito_circulo', as: :remito_circulo

  devise_for :usuarios, :controllers => {:registrations => "user/registrations"}
  resources :usuarios do
    collection {
      post 'sign_up', to: 'usuarios#create'
    }
  end
  resources :admins, controller: :usuarios
  resources :coordinador, controller: :usuarios


  get 'carts/show'
  get '/carts/create_pedido', to: 'carts#create_pedido', as: :create_pedido
	get '/carts/success/:id', to: 'carts#success', as: :success


  resources :productos do
    collection { post 'upload' }
    collection { put 'edit_multiple' }
		delete 'delete/:id', to: 'productos#delete', as: :delete
  end


  resources :categorias
  resources :pedidos, only: [:index, :show, :edit, :destroy]
  resources :home
  resources :steps
  resources :dossiers
  resources :faqs
  resources :geo_reports
  resources :dashboards
  resources :reports, only: [:index]

  resource :cart, only: [:show] do
    put 'add/:producto_id', to: 'carts#add', as: :add_to
    put 'remove/:producto_id', to: 'carts#remove', as: :remove_from
	end

	get "/callback" => "facebook#callback"
	get "/facebook_profile" => "facebook#facebook_profile"

  root to: 'home#index'

end
