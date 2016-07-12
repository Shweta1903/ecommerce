Rails.application.routes.draw do
 
  resources :addresses
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users, :controllers => {:sessions => "users/sessions", :omniauth_callbacks => 'users/omniauth_callbacks'}
  #get 'welcome/index'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'welcome#index'

   get "search" => "welcome#search"
   get "my_cart" => "carts#my_cart"
   get "add_to_cart" => "carts#add_to_cart"
   get "change_quantity" => "carts#change_quantity"   
   get "destroy" => "carts#destroy"

   get "update_total_price" => "carts#update_total_price"
   
    resources :products
    resources :categories
    resources :checkouts
    resources :orders,        only: [:index, :show]

    post "order_summary" => "checkouts#order_summary"
    get "payment" => "checkouts#payment"
    post "process_payment" => "checkouts#process_payment"

    post "/orders/:id" => "orders#show"
    post "/hook" => "orders#hook"

    get "/receipt" => "checkouts#receipt"
  

    

    
  

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
