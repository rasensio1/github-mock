Rails.application.routes.draw do
  root 'welcome#index'
  get '/auth/github', as: :login
  get '/auth/twitter/callback', to: "sessions#create"
end
