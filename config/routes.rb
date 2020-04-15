Rails.application.routes.draw do
  root 'top_pages#home'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/:name', to: 'users#show'
  get '/:name/setting', to: 'users#edit'
  patch '/:name/setting', to: 'users#update'
end
