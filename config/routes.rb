Rails.application.routes.draw do
  root 'home#index', as: :home
  get 'home', to: 'home#index'

  devise_for :users
  
  namespace :api do
    resources :users, only: %w[show]

    devise_for :users, defaults: { format: :json }, class_name: 'ApiUser',
                        skip: [:invitations, :passwords, :confirmations, :unlocks],
                        path: '', path_names: { sign_in: 'login', sign_out: 'logout', signup: 'signup', registration: 'signup' }

    devise_scope :user do
      #get 'login', to: 'devise/sessions#new'
      #delete 'logout', to: 'devise/sessions#destroy'
    end
  end
end
