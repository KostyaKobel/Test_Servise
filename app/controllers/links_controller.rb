class LinksController < ApplicationController
  def index
  end

  def show
  end

  def new
  end

  def create
    linkened = Linkened.new(link_params[:original_url])
    @link = linkened.generate_short_link
  end

  def edit
  end

  def destroy
  end

  private

  def link_params
    params.require(:link).permit(:original_url, :short_url)
  end
end
