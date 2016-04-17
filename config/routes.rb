Rails.application.routes.draw do

  resources :posts
  resources :comments

  root to: "sign_up#login"
  post "login", to: "sign_up#login"
  post "sign_up", to: "sign_up#create"
  delete "sign_up", to: "sign_up#destroy"

  post "posts/create", to: "posts#create"
  post "post/new", to: "posts#new"
  delete "post/:id", to: "posts#delete"

  post "post/:id", to: "comments#create"
  patch "comment/:id/choose_top_comment", to: "comments#choose_top_comment"
  patch "comment/:id/choose_bad_comment", to: "comments#choose_bad_comment"

  get "index", to: ""

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

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
