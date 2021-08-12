class LinksController < ApplicationController
  before_action :link_find, except: [:index, :new, :create]
  def index
    @links = Link.all
  end

  def show; end

  def new
    @link = Link.new
  end

  def create
    linkened = Linkened.new(link_params[:original_url])
    @link = linkened.generate_short_link
    if @link.save
      redirect_to link_path(@link)
    else
      render :new
    end
  end

  def edit; end

  def update
    if @link.update(link_params)
      redirect_to @link, success: "Your Link success updated"
    else
      render :edit
    end
  end

  def destroy
    @link.destroy!
    redirect_to links_path
  end

  private

  def link_find
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:original_url, :short_url)
  end
end
