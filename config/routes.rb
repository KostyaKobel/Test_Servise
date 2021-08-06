Rails.application.routes.draw do
  get 'home/index'
  get 'links/index'
  get 'links/show'
  get 'links/new'
  get 'links/create'
  get 'links/edit'
  get 'links/destroy'

  post '/links' => 'links#create'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
