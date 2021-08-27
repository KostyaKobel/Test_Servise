Rails.application.routes.draw do
  root to: 'links#index'
  # get '/s/:slug', to: 'links#show', as: :short
  namespace :admin do
    resources :links, only: [:index, :show, :destroy]
  end
  delete 'link_destroy' => 'admin/links#link_destroy'
  resources :links
end
