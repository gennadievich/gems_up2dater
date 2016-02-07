class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :display_errors_for

  def display_errors_for(smth)
    errors = smth.errors.full_messages.join("<br/>").html_safe

    flash.now[:error] = errors
  end
end
