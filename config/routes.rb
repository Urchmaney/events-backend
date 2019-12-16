Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      post '/login', to: 'sessions#create'
      post '/register', to: 'users#create'
      get '/events/all', to: 'events#all'
      get 'events/:id/organizers', to: 'events#organizers'
      get 'events/:id/comments', to: 'comments#index'
      post 'events/:id/comments', to: 'comments#create'
    end
  end 
end
