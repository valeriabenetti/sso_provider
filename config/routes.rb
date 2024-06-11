Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users

  post 'sign_in', to: 'authentication#sign_in'
  delete 'sign_out', to: 'authentication#sign_out'
  patch 'change_password', to: 'authentication#change_password'

  root to: 'home#index'
end