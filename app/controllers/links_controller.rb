class LinksController < ApplicationController
  before_action :link_find, except: [:index, :new, :create]
  before_action :access_password, only: [:edit, :destroy]

  def index
    @links = Link.all
  end

  def show
    visit_link(@link.shortened_url)
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
    if action_name == 'show'
      link.update_attributes(visit_link_count: 1)
    else
      visit_link_count
    end
  end

  def access_password
    binding.pry
    link = @link
    if action_name == 'edit'
      if link.include?(link.generate_link_password)
        redirect_to link_path(link)
      else
        redirect_to links_path
      end
    elsif action_name == 'destroy'
      if link.include?(link.generate_link_password)
        link.destroy
      else
        redirect_to links_path
      end
    end
  end
end
