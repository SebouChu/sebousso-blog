Rails.application.routes.draw do
  match "/delayed_job" => DelayedJobWeb, :anchor => false, :via => [:get, :post]

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  namespace :admin do
    resources :articles, param: :uid do
      member do
        match :publish, via: [:put, :patch]
      end
    end
    resources :users, param: :uid, only: [:index, :show]

    root 'dashboard#index'
  end

  resources :articles, param: :uid, only: [:index, :show]

  root 'home#index'
end
