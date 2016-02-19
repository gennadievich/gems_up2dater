class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :display_errors_for, :current_user, :check_if_admin

  def display_errors_for(model, flash_type = :warning)
    errors = model.errors.full_messages.join("<br/>").html_safe

    flash.now[flash_type] = errors
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def login(user)
    session[:user_id] = user[:id]
    user.sign_in_count += 1
    user.save
  end

  def logout
    session[:user_id] = nil
  end

  def check_if_admin
    redirect_to root_path, flash:{danger: "You don't have access to this page"} unless current_user.admin?
  end
end
