class ProjectsController < ApplicationController

  before_action :set_user_projects, only: [:index, :create]

  def all_projects
    @projects = Project.order('id ASC')
  end

  def show
    @project = current_user.projects.find(params[:id])
  end

  def new
    @project = current_user.projects.new
    @user_projects = current_user.projects.order('name ASC')

    respond_to { |format| format.js }
  end

  def create
    @project = current_user.projects.build(project_params)

    if @project.save
      flash.now[:success] = "Project '#{@project.name}' successfully created!"
      respond_to { |format| format.js }
    else
      display_errors_for(@project)
      respond_to { |format| format.js }
    end
  end

  def add_gem
    gem_name = params[:ruby_gem][:name]
    gem_version = params[:ruby_gem][:vesion]

    if gem_name.blank?
      redirect_to :back, flash: {warning: "Please enter gem name."}
    end

    #try to get info from rubygems

    #find or create gem in local db (update current version)

    #add gem to users project

  end

  def destroy
    @project = Project.find(params[:id])

    if current_user.admin? || @project.user == current_user
      @project.delete
      redirect_to :back, flash: {success: "Project '#{@project.name}' was deleted."}
    else
      redirect_to :back, flash: {danger: "You are not allowed to delete this project!"}
    end
  end

  private

  def project_params
    params.require(:project).permit(:name, :description, :link)
  end

  def set_user_projects
    @user_projects = current_user.projects.order('name ASC')
  end
end
