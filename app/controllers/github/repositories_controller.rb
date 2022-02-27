class Github::RepositoriesController < ApplicationController
  def index
    @repositories = Github::Repository.search_repositories(params[:query])
    respond_to do |format|
      format.js
    end
  end
end
