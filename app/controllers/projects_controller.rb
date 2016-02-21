class ProjectsController < ApplicationController
  def index
    @user_projects = current_user.projects.all
  end

  def new
    @project = current_user.projects.new
  end

  def create
    raise params.inspect
  end
end
