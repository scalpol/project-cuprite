Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'challenges/index'

  get 'challenges/show'

  get 'challenges/new'

  get 'challenges/edit'

  get 'orbs/index'

  root 'challenges#index', as: 'explore'

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

  resources :challenges, except: [:edit, :update] do
    member do
      get 'confirm'
      post 'confirmed'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
