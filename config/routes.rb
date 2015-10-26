Rails.application.routes.draw do
  root 'welcome#index'
  get '/auth/github', as: :login
  get '/auth/github/callback', to: "sessions#create"
end
