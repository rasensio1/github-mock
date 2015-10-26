Rails.application.routes.draw do
  root 'welcome#index'
  get '/auth/github', as: :login
  get '/logout', to: "sessions#destroy"
  get '/auth/github/callback', to: "sessions#create"
  get '/profile', to: "users#show"
end
