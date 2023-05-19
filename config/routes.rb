Rails.application.routes.draw do

  # Define routes for the Devise gem
  devise_for :users

  resources :attendances, only: [:index, :show, :new, :create, :edit, :update, :destroy] do
  end

  # Define routes for the Event and Attendance models
  resources :events do
    resources :attendances, only: [:new, :create, :index, :show, :destroy, :edit, :update]
  end

  resources :events, only:[:show] do
    resources :event_picture, only: [:create]
    end

  # Define routes for the User model
  resources :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  root to: "events#index"

  # Stripe urls
  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end
  
end
