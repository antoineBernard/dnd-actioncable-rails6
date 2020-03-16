Rails.application.routes.draw do
  root 'candidates#index'

  resources :candidates, only: %i(index)
end
