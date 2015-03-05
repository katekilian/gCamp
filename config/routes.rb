Rails.application.routes.draw do

  root 'welcome#index'

  get '/about', to: 'about#index'

  get '/terms', to: 'terms#index'

  get '/faq', to: 'common_questions#index'

  get 'sign-up', to: 'registrations#new', as: 'sign-up'

  resources :tasks

  resources :users

  resources :projects, only: [:index, :show, :new, :create, :edit, :update, :destroy]

end
