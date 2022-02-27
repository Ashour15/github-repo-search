class Github::RepositoriesController < ApplicationController
  def index
    @page = 1
    @repositories = Github::Repository.search_repositories(params[:query])
    @repositories = @repositories['items']
    respond_to do |format|
      format.js
    end
  end
end
