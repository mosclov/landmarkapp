Rails.application.routes.draw do

  post '/favorites/create'
  post '/favorites/create_from_listing'
  post '/favorites/unfavorite'
  post '/favorites/unfavorite_from_listing'
  post '/favorites/unfavorite_from_profile'

  # get 'favorites/favorite'
  #
  # get 'favorites/unfavorite'

  resources :reviews

    get 'landmarks/search_results'

  resources :landmarks do
    resources :follows, :controller => 'follows_landmarks', :only => [:create, :destroy]
    collection do
      get 'map_locations'
    end

    member do
      get 'map_location'
    end
      resources :star_ratings, except: [:show, :index]
  end

  post 'search/location_search'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  resources :users, only: [:show, :index, :destroy] do
    member do
      get :following, :followers
    end
    collection do
      get :favorited
    end
  end

  root 'welcome#index'
  resources :relationships,       only: [:create, :destroy]
  resources :favorites,       only: [:create, :destroy]
  get 'welcome/about'
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
