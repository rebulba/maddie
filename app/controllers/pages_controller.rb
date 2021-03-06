class PagesController < ApplicationController
  before_filter :authenticate_user!

  def new
    @page = PageOrderer.new(current_user_domain.pages).new_page
  end

  def index
    render_pages
  end

  def create
    @page = current_user_domain.pages.new(page_params)
    if @page.save
      flash[:messages] = ["Page Saved"]
      redirect_to pages_url
    else
      flash[:errors] = @page.errors.full_messages
      render :new
    end
  end

  def edit
    @page = current_user_domain.pages.find(params[:id])
  end

  def update
    @page = current_user_domain.pages.find(params[:id])
    if @page.update(page_params)
      flash[:messages] = ["Page Updated"]
      redirect_to pages_url
    else
      flash[:errors] = @page.errors.full_messages
      render :edit
    end
  end

  def destroy
    page = current_user_domain.pages.find(params[:id])
    page.destroy
    redirect_to pages_url
  end

  private

  def authenticate_user!
    if !current_user
      super
    elsif current_user_domain
      true
    else
      redirect_to :root, alert: ["You do not have permission to edit that!"]
    end
  end

  def render_pages
    @pages = current_user_domain.pages
    render "index"
  end

  def page_params
    params.require(:page).permit(:title, :body, :hidden, :order, :url_key)
  end
end
