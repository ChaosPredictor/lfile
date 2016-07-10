Rails.application.routes.draw do

  get 'run_files/new'

  get 'lines/new'

  get 'instalations/new'

  get 'password_resets/new'

  get 'password_resets/edit'

  get 'sessions/new'

  get 'users/new'

  get 'users/new'

  get 'users/new'

  #get 'static_pages/help'
  #get 'static_pages/about'
  #get 'static_pages/contact'
  #root 'static_pages#home'


	root                       'static_pages#home'
	get    'help'           => 'static_pages#help'
	get    'about'          => 'static_pages#about'
	get    'contact'        => 'static_pages#contact'
	get    'signup'         => 'users#new'
	get    'login'          => 'sessions#new'
	post   'login'          => 'sessions#create'
	delete 'logout'         => 'sessions#destroy'
	get    'instalations'   => 'instalations#index'
	get    'instanew'       => 'instalations#new'
	get    'instaedit'      => 'instalations#edit'
	get    'createfile'     => 'run_files#new'
	post   'createfile'     => 'run_files#create'
	post   'download_file'  => 'run_files#download_file'
	resources :users do
		member do
			get :following, :followers
		end
	end
	resources :instalations do
		member do
			get :lines
		end
	end
	
	resources :account_activations,   only: [:edit]
	resources :password_resets,       only: [:new, :create, :edit, :update]
	resources :microposts,            only: [:create, :destroy]
	resources :relationships,         only: [:create, :destroy]
	resources :instalations#,          only: [:new, :index, :edit, :update, :create, :destroy]
	resources :lines#,            only: [:create, :destroy]	
	resources :steps
	resources :run_files
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
