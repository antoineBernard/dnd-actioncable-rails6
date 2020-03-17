Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root 'candidates#index'

  resources :candidates, only: %i(index)

  post 'update_status/:id/:status', to: 'candidates#update_status', as: :update_status
end
