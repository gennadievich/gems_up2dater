class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.role_id = 1 #Change to CONSTANT role

    if @user.save
      redirect_to users_path, flash: {success: "User created!"}
    else
      display_errors_for(@user)
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
