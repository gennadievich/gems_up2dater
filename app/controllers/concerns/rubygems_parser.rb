module RubyGemsParser
  extend ActiveSupport::Concern
  require 'rubygems'
  require 'gems'

  def search_gem(gem_name)

    gem = Gems.info(gem_name)

    raise gem.inspect
  end
end