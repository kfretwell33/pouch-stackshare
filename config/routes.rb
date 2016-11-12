Rails.application.routes.draw do
  
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  #Only leaving this routing for testing - disable for production
    resources :widgets
  

  #brand login routing
    devise_for :brands, controllers: { registrations: "brands/registrations" }

  #user login through facebook routing (not using devise)
    get 'sessions/url', to: 'sessions#redirect'
    get 'auth/:provider/callback', to: 'sessions#create'
    get 'auth/failure', to: redirect('/')
    get 'signout', to: 'sessions#destroy', as: 'signout'
    resources :sessions, only: [:create, :destroy, :show], as: :fblogin #"as: :fblogin" required so conflict with devise doesn't occur
  

    #devise for users
    devise_for :users, controllers: { registrations: "users/registrations", sessions: "users/sessions", passwords: "users/passwords", omniauth_callbacks: "users/omniauth_callbacks" }
    devise_scope :user do 
      get 'users/sessions/facebook', to: 'users/sessions#redirect'
      get 'users/sessions/email', to: 'users/sessions#redirect_email'
      get 'users/registrations/email', to: 'users/registrations#redirect_email_sign_up'
      get 'users/registrations/login', to: 'users/sessions#create'
      get 'sign_out', to: 'devise/sessions#destroy', as: :destroy_user_sessions 
    end
    

  #display welcome folder (it's your homepage)
    resource :welcome, only: [:show]  
    #get '/', to: redirect('http://www.pouch-app.com/')
    # You can have the root of your site routed with "root"  
    root 'welcome#index'
    get '/welcome/about'

  #Set up routing for campaigns controller & views
    #These are necessary because they don't come included in the standard "resources: xyz" routing
      get 'campaigns/track'
      get 'campaigns/pouch/:id', to: 'campaigns#pouch', as: :pouch_campaign
      get 'campaigns/shop/:id', to: 'campaigns#shop'
    #this should take care of the basic functions 
      resources :campaigns, only: [:create, :new, :show]
    #Don't think these are necessary because they are already handled with the above? 
      #get 'new-campaign' => 'campaigns#new'
      #get 'campaigns/:id', to: 'campaigns#show'
      #get 'campaigns/new'

  #Set up routing for deals
    resources :deals, only: [:update, :show]

  #Set up routing for API - probably want to turn off :index when you go live
    resources :api, only: [:create, :show, :index]
    get 'api/deals/:id', to: 'api#deals', as: :api_deals #"as: :api_deals" necessary for api "show.json.jbuilder" to have the url for deals to display
    get 'api/detail/:id', to: 'api#detail', as: :api_detail #"as: :api_detail" necessary for api "deals.json.jbuilder" to have the url for detail to display


    #display privacy policy
    get 'privacy/display'
end




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
#end
