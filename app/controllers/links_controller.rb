class LinksController < ApplicationController
  before_action :link_find, except: [:index, :new, :create]

  def index
    @links = Link.all
  end

  def show
    action_name == 'show'? @link.update_attributes(visit_link_count: 1) : 0
  end

  def new
    @link = Link.new
  end

  def create
    linkened = Linkened.new(link_params[:original_url])
    @link = linkened.generate_short_link
    if @link.save
      flash[:notice] = "Successfully create Link"
      redirect_to link_path(@link)
    else
      flash.now[:error] = "Invalid Link format"
      render :new
    end
  end

  def edit; end

  def update
    if @link.update(link_params)
      flash[:notice] = "Your Link success updated"
      redirect_to @link
    else
      flash.now[:error] = "Invalid Link format"
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
