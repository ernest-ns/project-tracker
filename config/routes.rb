Rails.application.routes.draw do
  post 'webhook/add_data'

  resources :answers, only: [:index]
  root 'answers#index'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
