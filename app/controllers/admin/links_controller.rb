class Admin::LinksController < ApplicationController
before_action :link_find, except: [:index, :new, :create]
  include HttpAuthConcern
  http_basic_authenticate_with name: 'admin', password: '1q2w3e4rpassword'

  def index
    @links = Link.all
  end

  def show; end

  def destroy
    @link.shortened_url.destroy
    redirect_to admin_links_path
  end

  private

  def link_find
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:original_url, :short_url)
  end

end
