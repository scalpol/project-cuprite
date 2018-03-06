Rails.application.routes.draw do
  get 'pruebas/index'

  get 'pruebas/admin'

  root 'pruebas#index'

  devise_for :players
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
