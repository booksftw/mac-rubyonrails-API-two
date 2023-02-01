Rails.application.routes.draw do
  get '/categories/', to: 'categories#index'
  post '/categories/', to: 'categories#create'
  # get '/categories/:id', to: 'categories#getByCategory'
  
  get '/todos/:id', to: 'todos#getByCategory'
  patch '/todos/:id', to: 'todos#NzPatch'
  resources :todos
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "todos#index"
end
