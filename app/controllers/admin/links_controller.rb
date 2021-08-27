class Admin::LinksController < ApplicationController
  before_action :link_find, except: [:index, :new, :create, :link_destroy]
  include HttpAuthConcern
  http_basic_authenticate_with name: ENV['ADMIN_NAME'], password: ENV['ADMIN_PASSWORD']

  LINKS_PER_PAGE = 5

  def index
    @links = if params[:q].present?
      Link.where("original_url LIKE ?", "%#{params[:q]}%").paginate( page: params[:page], per_page: LINKS_PER_PAGE)
      else
        Link.paginate( page: params[:page], per_page: LINKS_PER_PAGE )
      end
  end

  def show; end

  def destroy
    Link.destroy_short_url
    redirect_to admin_links_path, notice: 'Short Link deleted successfully'
  end

  def link_destroy
    Link.link_destroy_greater_than_two
    redirect_to admin_links_path, notice: 'Link Greater Than Two Months deleted successfully'
  end

  private

  def link_find
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:original_url)
  end

end
