Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  get 'challenges/explore'

  root 'challenges#explore'

  get 'barracks/created'
  get 'barracks/participations'
  get 'barracks/important'
  get 'barracks/archived'

  resources :challenges, except: [:edit, :update, :index] do
    member do
      get 'confirm'
      post 'confirmed'
    end
    post 'confirm_result/:party_id', to: 'confirmations#create', as: 'confirm_result'
  end

  devise_for :players

  resources :orbs, only: [:index]

  resources :participations, only: [:create, :index]

  resources :billings, only: [:index, :create, :destroy] do
    collection do
      get 'pre_pay'
      get 'execute'
    end
  end

  resources :parties, only: [] do
    resources :participations, only: [:new]
  end

  resources :cases
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
