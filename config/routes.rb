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
  match '/order_payment' => 'orders#order_payment', as: :order_payment
  match '/account' => 'users#account', :as => :account
  match '/' => 'site#index'
  match '/about' => 'site#about'
  match '/documents' => 'site#documents'
  match '/payment' => 'site#payment', :as => :payment_page
  match '/services' => 'site#services'
  match '/contacts' => 'site#contacts'
  match '/login' => 'user_sessions#new', :as => :login
  match '/logout' => 'user_sessions#destroy', :as => :logout
  match '/:controller(/:action(/:id))'
  root :to => 'site#index'
end
