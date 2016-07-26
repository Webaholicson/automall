Rails.application.routes.draw do
  get 'service/index'
  get 'service/new'
  get 'service/edit'
  get 'service/save'
  get 'service/delete'
  get '/service', to: 'service#index'

  get 'listing/show'
  get 'listing/new'
  get 'listing/saved'
  get 'listing/list'
  post 'listing/list'
  post 'listing/save'
  get 'listing/delete'
  get 'listing/edit'
  get '/buy', to: 'listing#list'
  get '/sell', to: 'listing#new'

  get 'page/home'
  get 'page/show'
  get 'page/not_found'

  get 'account/dashboard'
  get 'account/index'
  get 'account/edit'
  get 'account/login'
  get 'account/logout'
  get 'account/register'
  post 'account/save'
  post 'account/login_post'
  post 'account/register_post'

  namespace :admin do
    resources :listings, :users, :services, :admin_user, :settings, :attributes
  end

  match ':controller(/:action(/:id))', controller: /admin\/[^\/]+/, action: /[^\/]+_post/, via: [:post]
  match ':controller(/:action(/:id))', controller: /admin\/[^\/]+/, via: [:get]
  get '/admin', to: 'admin/index#dashboard'
  #get '/admin/:page', to: 'admin/index#dashboard'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'page#home'

  get '/:page', to: 'page#show', page: /.*/

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
