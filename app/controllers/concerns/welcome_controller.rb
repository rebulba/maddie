class WelcomeController < ApplicationController
  before_filter :ensure_domain_has_user!, only: [:show]

  def index
    @pages = PageOrderer.new(domain).visible_pages
  end

  def show
    @page = domain.pages.find_by_url_key(params[:url_key])
    raise ActiveRecord::RecordNotFound unless @page
  end
end
