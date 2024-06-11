Rails.application.routes.draw do
  # Sessions controller routes
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  # OAuth controller routes
  use_doorkeeper
end
