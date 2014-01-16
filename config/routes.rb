Curri::Application.routes.draw do

  mount StyleGuide::Engine => "/style-guide" if Rails.env.development?
  root to: 'classrooms#index'

  resources :classrooms, except: [:show] do
    resources :requesters, only: [:index, :show, :update] do
      patch 'remove', on: :member
    end
    # get 'requesters', to: 'requesters#index'
    # patch 'requesters/reset_status', to: 'requesters#reset_status', as: "reset_status"
    resources :tracks do
      get 'analytics', to: 'analytics#show'
      resources :ratings, only: [:create]
      resources :checkpoints, except: [:index, :show]
    end

    resources :invitations, only: [:new, :create, :destroy]
  end

  # Student Registration
  namespace :students do
    get 'new/:token', action: 'new', as: 'new'
    post 'create'
    get 'login/:token', action: 'login', as: 'login'
    post 'enroll'
  end

  # Teacher Registration
  get '/register', to: "teachers#new"
  post "teachers/create"

  # User Authentication
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "logout", to: "sessions#destroy"
  resources :password_resets, except: [:show, :destroy, :index]

  # User Profiles
  get '/profile/edit', to: "users#edit_profile", as: "edit_profile"
  patch '/profile', to: 'users#update_profile', as: 'update_profile'

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
