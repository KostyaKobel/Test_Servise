class LinksController < ApplicationController
  before_action :link_find, except: [:index, :new, :create]
  before_action :access_password, only: [:edit, :destroy]

  LINKS_PER_PAGE = 5

  def index
    @links = Link.all.paginate( page: params[:page],
                                per_page: LINKS_PER_PAGE )
  end

  def show
    @link.register_visit
    redirect_to @link.original_url
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    @link.generate_link_password
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
      redirect_to links_path
    else
      flash.now[:error] = "Invalid Link format"
      render :edit
    end
  end

  def destroy
    @link.destroy
    redirect_to links_path
  end

  private

  def link_find
    @link = Link.find(params[:id])
  end

  def link_params
    params.require(:link).permit(:original_url)
  end


  def access_password
    link = Link.find_by(params[:generate_link_password])
    link == link.generate_link_password { |link| link.redirect_to edit_link_path(link) } if action_name == 'edit'
    link == link.generate_link_password { |link| link.link.destroy } if action_name == 'destroy'
  end
end
