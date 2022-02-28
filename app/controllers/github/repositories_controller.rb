class Github::RepositoriesController < ApplicationController
  RESULTS_PER_PAGE = 10
  
  before_action :check_required_params
  before_action :set_page_params

  def index
    @page = params[:page].to_i
    @query = params[:query]
    @repositories = Github::Repository.search_repositories(search_params)
    respond_to do |format|
      if @repositories.present?
        format.js
      else
        puts "Here"
        format.js { flash.now[:notice] = "Something went wrong, please try again!" }
      end
    end
  end

  private

  def set_page_params
    params[:per_page] = RESULTS_PER_PAGE
    params[:page] = 1 if params[:page].blank?
  end

  def check_required_params
    if params[:query].blank?
      flash.now[:notice] = "Please enter a search term"
      render :index
    end
  end

  def search_params
    params.permit(:query, :page, :per_page)
  end
end
