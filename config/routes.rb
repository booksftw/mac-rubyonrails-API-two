Rails.application.routes.draw do
  patch '/todos/:id', to: 'todos#NzPatch'
  resources :todos
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root "todos#index"
end
