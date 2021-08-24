class LinksController < ApplicationController
  before_action :link_find, except: [:index, :new, :create]
  before_action :access_password, only: [:edit, :destroy]

  def index
    @links = Link.all
  end

  def show
    # @link = Link.find_by_short_url(params[:short_url])
    # render 'errors/404', status: 404 if @link.nil?
    @link.update_column(:last_date_visit_link, Time.new()) if visit_link(@link)
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
    params.require(:link).permit(:original_url, :short_url, :visit_link_count)
  end


  def visit_link(link)
    link = @link
    link.update_attribute(:visit_link_count, link.visit_link_count + 1) if action_name == 'show'
  end

  def access_password
    link = Link.find_by(params[:generate_link_password])
    link == link.generate_link_password { |link| link.redirect_to edit_link_path(link) } if action_name == 'edit'
    link == link.generate_link_password { |link| link.link.destroy } if action_name == 'destroy'
  end
end
