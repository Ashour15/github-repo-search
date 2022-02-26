class Github::RepositoriesController < ApplicationController
  def index
    @repositories = Github::Repository.search_repositories(params[:query])
  end
end
