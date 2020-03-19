Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  root 'candidates#index'

  resources :candidates, only: %i(index)

  post 'candidates/:id/update_status/:status', to: 'candidates#update_status', as: :update_status
end
