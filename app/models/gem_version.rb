class GemVersion < ApplicationRecord
  belongs_to :ruby_gem

  def self.set_actual_version
    order('date desc').where('prerelease = ?', false).first.update_column(:actual, :true)
  end

  #ToDo freshest
end
