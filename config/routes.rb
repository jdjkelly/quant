Bodyimage::Application.routes.draw do
  root :to => 'home#index'

  resource :home,
    :only => [:index]

  resources :measurements
  resources :fat_percentages
  resources :fat_masses
  resources :lean_masses
  resources :weights

  resources :passwords,
    :controller => 'clearance/passwords',
    :only => [:create, :new]

  resource :session,
    :controller => 'clearance/sessions',
    :only => [:create, :new, :destroy]

  resources :users,
    :controller => 'clearance/users',
    :only => [:create, :new] do
      resource :password,
        :controller => 'clearance/passwords',
        :only => [:create, :edit, :update]
    end

  get '/withings_account/callback' => 'withings_account#callback'

  get '/sign_in' => 'clearance/sessions#new', :as => 'sign_in'
  delete '/sign_out' => 'clearance/sessions#destroy', :as => 'sign_out'
  get '/sign_up' => 'clearance/users#new', :as => 'sign_up'


  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.


  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
