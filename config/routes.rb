Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root 'candidates#index'

  resources :candidates, only: %i(index)

  post 'candidates/:id', to: 'candidates#update'
end