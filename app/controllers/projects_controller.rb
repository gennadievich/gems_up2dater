class ProjectsController < ApplicationController

  #include RubyGemsParser

  PROJECTS_PER_PAGE = 5

  def index
    @user_projects = current_user.projects.paginate(:page => params[:page], :per_page => PROJECTS_PER_PAGE).order('name ASC')
  end

  def all_projects
    @projects = Project.paginate(:page => params[:page], :per_page => PROJECTS_PER_PAGE).order('id ASC')
  end

  def show
    @project = current_user.projects.find(params[:id])
    @project_gems = @project.ruby_gems.all
  end

  def new
    @project = current_user.projects.new
  end

  def create
    @project = current_user.projects.build(project_params)

    if @project.save
      redirect_to user_projects_path, flash: {success: "Project '#{@project.name}' successfully created!"}
    else
      display_errors_for(@project)
      render :new
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
end
