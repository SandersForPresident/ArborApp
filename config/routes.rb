Rails.application.routes.draw do
  root 'pages#home'

  resources :skills, only: [:show]
  resources :groups, only: [:index, :show]

  get '/auth/:provider/callback', to: 'oauth_callbacks#show'
  get '/auth/failure', to: 'oauth_failures#show'
  get '/logout', to: 'sessions#destroy', as: 'logout'
end
