Rails.application.routes.draw do
  root 'top_pages#home'
  get '/signup', to: 'users#new'
  get '/:name', to: 'users#show'
  resources :users
end
