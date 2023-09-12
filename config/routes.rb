Rails.application.routes.draw do
  root to: 'home#index'

  resources :reservations, only: [:index, :create, :edit, :update, :destroy] do
    collection do
      post :confirm
    end
  end

  resources :rooms do
    get :own, on: :collection
  end

  namespace :users do
    resource :profile, only: [:show, :edit, :update], controller: 'profile'
    resource :account, only: :show, controller: 'account'
  end

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
end
