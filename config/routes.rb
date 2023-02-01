Rails.application.routes.draw do
  get '/categories/', to: 'categories#index'
  post '/categories/', to: 'categories#create'
  delete 'categories/:id', to: 'categories#destroy'
  put 'categories/:id', to: 'categories#update' 
  
  get '/todos/:id', to: 'todos#getByCategory'
  patch '/todos/:id', to: 'todos#NzPatch'
  resources :todos
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "todos#index"
end
