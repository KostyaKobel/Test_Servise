Rails.application.routes.draw do
  root to: 'links#index'
  namespace :admin do
    resources :links, only: [:index, :show, :destroy]
  end
  resources :links
end
