Rails.application.routes.draw do
  root 'top_pages#home'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/:name', to: 'users#show'
  resources :users
end
