class GemVersionsController < ApplicationController
  def index
    ruby_gem = RubyGem.find(params[:ruby_gem_id])

    @gem_versions = ruby_gem.gem_versions.order('name desc')
    respond_to { |format| format.js }
  end
end