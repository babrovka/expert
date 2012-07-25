Expert::Application.routes.draw do
  resources :deliveries
  resources :payments
  resources :users

  resources :orders do
    member do
      get :change_status
    end
  end

  resources :messages
  resources :order_types
  resources :password_resets
  resource :user_session
  match '/account' => 'users#account', :as => :account
  match '/' => 'site#index'
  match '/about' => 'site#about'
  match '/payment' => 'site#payment'
  match '/services' => 'site#services'
  match '/contacts' => 'site#contacts'
  match '/login' => 'user_sessions#new', :as => :login
  match '/logout' => 'user_sessions#destroy', :as => :logout
  match '/:controller(/:action(/:id))'
end
