Rails.application.routes.draw do
  root 'users#home'

  get 'signup' => 'users#new'

  get 'user/new'

  resources :users
  resources :courses
  resources :subjects
  resources :instructors
  resources :enrollments

  get 'search' => 'courses#search'
  get 'new_search' => 'courses#new_search'

  get 'help' => 'static_pages#help'

  get 'about' => 'static_pages#about'

  get 'contact' => 'static_pages#contact'

  get 'readme' => 'static_pages#readme'

  get 'login' => 'sessions#new'

  post 'login' => 'sessions#create'

  delete 'logout' => 'sessions#destroy'
end
