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
  get 'remitos_pedido/index'
  get 'remitos_pedido/generate'
  get '/transaction/generar/:ciclo_id' => 'transactions#generar', as: :transaction_generar

  resources :suppliers

  get 'compras/add_status/:id', to: 'compras#add_status', as: :add_status
  get 'compras/refresh_status/:id', to: 'compras#refresh_status', as: :refresh_status


  resources :circulos do
    post 'add_usuario', to: 'circulos#add_usuario', as: :add_usuario
    delete 'remove_usuario/:usuario_id', to: 'circulos#remove_usuario', as: :remove_usuario
    post 'abandonar', to: 'circulos#abandonar', as: :abandonar
  end

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


  resources :productos do
    collection { post 'upload' }
    collection { put 'edit_multiple' }
  end


  resources :categorias
  resources :pedidos, only: [:index, :show, :edit]
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

  root to: 'home#index'

end
