Rails.application.routes.draw do
  root 'pages#home'

  resources :skills, only: [:show]
  resources :teams, only: [:index, :show]

  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#failure'
  get '/logout', to: 'sessions#logout', as: 'logout'
end
