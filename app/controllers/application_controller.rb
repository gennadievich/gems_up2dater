class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :display_errors_for

  def display_errors_for(smth)
    smth.errors.full_messages.each do |error|
      flash.now[:error] = error
    end
  end
end
