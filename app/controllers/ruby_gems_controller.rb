class RubyGemsController < ApplicationController
  before_action :check_if_admin
  before_action :set_ruby_gems, only: [:index, :create, :destroy]
  before_action :find_ruby_gem, only: [:show, :destroy]

  def search
    gem_name = ruby_gem_params[:name]
    @ruby_gem = RubyGem.find_by(name: gem_name)

    if gem_name.blank?
      flash.now[:warning] = "Please enter gem name!"
      respond_to { |format| format.js }
    else
      if @ruby_gem
        redirect_to(ruby_gem_path(@ruby_gem), format: :html)
      else
        @ruby_gem = RubyGem.new
        @gem_info = Gems.info(gem_name)

        if @gem_info.is_a?(Hash) && !@gem_info.blank?
          flash.now[:success] = "We don't have this gem yet!"
          respond_to { |format| format.js }
        else
          flash.now[:warning] = "Can't find '#{gem_name}' gem!"
        end
      end
    end
  end

  def track
    gem_name = ruby_gem_params[:name]
    gem_vers = ruby_gem_params[:version]
    project  = Project.find(params[:project_id])
    ruby_gem = RubyGem.find_by(name: gem_name)
    gem_vers = ruby_gem.gem_versions.find_by(name: gem_vers) if ruby_gem

    if gem_vers
      project.gem_versions << gem_vers
    end
  end

  def create
    @ruby_gem = RubyGem.new(ruby_gem_params)

    if @ruby_gem.save
      get_all_versions_for_gem(@ruby_gem)
      @ruby_gem.gem_versions.set_actual_version

      flash.now[:success] = "Gem '#{@ruby_gem.name}' successfully created!"
      respond_to { |format| format.js }
    end
  end

  def destroy
    if current_user.admin?
      @ruby_gem.gem_versions.delete_all
      @ruby_gem.delete

      flash.now[:success] = "Gem '#{@ruby_gem.name}' was successfully deleted."
      respond_to {|format| format.js}
    else
      flash.now[:danger] = "You are not allowed to delete gems."
    end
  end

  private

  def ruby_gem_params
    params.require(:ruby_gem).permit(:name, :description, :link, :total_downloads, :version)
  end

  def set_ruby_gems
    @ruby_gems = RubyGem.order("name asc")
  end

  def find_ruby_gem
    @ruby_gem = RubyGem.find(params[:id])
  end

  def get_all_versions_for_gem(gem)
    versions = Gems.versions(gem.name)
    versions.each do |version|
      gem.gem_versions.build(
                        name: version['number'],
                        date: version['built_at'],
                        this_version_downloads: version['downloads_count'],
                        actual: false,
                        prerelease: version['prerelease']
      )
      gem.save
    end
  end
end
