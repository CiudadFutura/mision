Rails.application.routes.draw do
  resources :suppliers

  resources :compras

  resources :circulos do
    post 'add_usuario', to: 'circulos#add_usuario', as: :add_usuario
    post 'abandonar', to: 'circulos#abandonar', as: :abandonar
  end

  devise_for :usuarios
  resources :usuarios
  resources :admins, controller: :usuarios
  resources :coordinador, controller: :usuarios


  get 'carts/show'

  resources :productos
  resources :categorias
  resources :pedidos, only: [:index]
  resources :home

  resource :cart, only: [:show] do
    put 'add/:producto_id', to: 'carts#add', as: :add_to
    put 'remove/:producto_id', to: 'carts#remove', as: :remove_from
    put 'create_pedido', to: 'carts#create_pedido', as: :create_pedido
  end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root to: 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
