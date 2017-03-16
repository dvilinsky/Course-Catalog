Rails.application.routes.draw do
  root 'static_pages#home'

  get 'signup' => 'users#new'

  get 'user/new'

  resources :users
  resources :courses
  resources :subjects
  resources :instructors

  get 'help' => 'static_pages#help'

  get 'about' => 'static_pages#about'

  get 'contact' => 'static_pages#contact'

  get 'readme' => 'static_pages#readme'

  get 'login' => 'sessions#new'

  post 'login' => 'sessions#create'

  delete 'logout' => 'sessions#destroy'
end
