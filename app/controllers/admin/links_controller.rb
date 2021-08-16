class Admin::LinksController < ApplicationController
before_action :link_find, except: [:index, :new, :create]
  include HttpAuthConcern
  http_basic_authenticate_with name: 'admin', password: '1q2w3e4rpassword'

  LINKS_PER_PAGE = 5

  def index
    @q = Link.ransack(params[:q])
    @links = @q.result.paginate( page: params[:page],
                                per_page: LINKS_PER_PAGE )
  end

  def show; end

  def destroy
    @link.short_url.destroy
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
