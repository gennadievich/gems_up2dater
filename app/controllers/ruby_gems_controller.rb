class RubyGemsController < ApplicationController
  def index
  end

  def new
    @ruby_gem = RubyGem.new
  end

  def create
    @ruby_gem = RubyGem.find_or_initialize_by(name: ruby_gem_params[:name])

    raise @ruby_gem.inspect
  end

  def show
    @ruby_gem = RubyGem.find(params[:id])
  end

  private

  def ruby_gem_params
    params.require(:ruby_gem).permit(:name, :version)
  end
end
