Virturlmin::Application.routes.draw do
 
  mount Ckeditor::Engine => '/ckeditor'

  resources :users  do
      collection do
        get :domain
        put :domain
        get :password 
        put :password 
      end
    end

  resources :blogs

  resources :files   do
      collection do
        get :zip
        get :unzip
        get :logout
        post :setlocale
      end
    end
 resources :sessions do
      collection do
        get :home
        get :yinsi
        get :logout
        post :setlocale
      end
    end
  resources :tops do
        collection do
        get :resume
        get :logout
        post :setlocale
      end
  end
  #  namespace :admin do |admin|
  #    admin.login '/',:controller => 'sessions',:action => 'new'
  #    admin.resources :sessions,:collection => {:home=>[:get,:post],:logout=>[:get,:post] ,:setlocale => :post}
  #    admin.resources :administrators
  #    admin.resources :sabro_firsts
  #  end
  namespace :admin do 
    match '/',:controller => 'sessions',:action => 'new'
    #    resources :sessions,:collection => {:home=>[:get,:post],:logout=>[:get,:post] ,:setlocale => :post}
    resources :sessions do
      collection do
        get :home
        get :logout
        post :setlocale
      end
    end
    resources :administrators
    resources :categories
    resources :blogs
    resources :links
    resources :pages
  end

  root :to => "sessions#new"

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
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
   # match 'files/:file'      ,      :controller => 'files',
   #           :action     => 'index'
match '/files/master/*file' => 'files#index' , :constraints => { :file => /.*/  } , :format => false
match '/files/zip/*file' => 'files#zip' , :constraints => { :file => /.*/  } , :format => false
match '/files/unzip/*file' => 'files#unzip' , :constraints => { :file => /.*/  } , :format => false
end
