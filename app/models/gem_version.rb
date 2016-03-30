class GemVersion < ApplicationRecord
  belongs_to :ruby_gem
  has_and_belongs_to_many :projects

  def self.set_actual_version
    order('date desc').where('prerelease = ?', false).first.update_column(:actual, :true)
  end

  #ToDo freshest
end
