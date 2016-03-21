Rails.application.routes.draw do

  resources :transaction_details
  resources :transactions
  resources :accounts
  get 'remitos_pedido/index'
  get 'remitos_pedido/generate'
  get 'transaction/generar'

  resources :suppliers

  resources :compras

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
    put 'create_pedido', to: 'carts#create_pedido', as: :create_pedido
  end

  root to: 'home#index'

end
