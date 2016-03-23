class RubyGemsController < ApplicationController
  before_action :set_ruby_gems, only: [:index, :create]

  def index
  end

  def new
  end

  def search
    gem_name = search_params[:name]
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

  def create
    @ruby_gem = RubyGem.new(ruby_gem_params)

    if @ruby_gem.save
      flash.now[:success] = "Gem '#{@ruby_gem.name}' successfully created!"
      respond_to { |format| format.js }
    end
  end

  def show
    @ruby_gem = RubyGem.find(params[:id])
  end

  private

  def search_params
    params.require(:ruby_gem).permit(:name)
  end

  def ruby_gem_params
    params.require(:ruby_gem).permit(:name, :description, :link, :total_downloads)
  end

  def set_ruby_gems
    @ruby_gems = RubyGem.order("name asc")
  end
end
