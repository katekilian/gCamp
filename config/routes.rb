Rails.application.routes.draw do

  root 'welcome#index'

  get '/about', to: 'about#index'

  get '/terms', to: 'terms#index'

  get '/faq', to: 'common_questions#index'

  resources :tasks, only: [:index, :new, :create, :show, :edit, :update]

end
