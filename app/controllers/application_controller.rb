class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include HttpAuthConcern
  http_basic_authenticate_with name: 'admin', password: 'password'
end
