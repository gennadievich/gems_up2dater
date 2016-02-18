class UsersController < ApplicationController
  def index
    @users = User.all.sort
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      login @user
      redirect_to user_path(@user), flash: {success: "You successfully registered!"}
    else
      display_errors_for(@user)
      render :new
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user.admin?
      redirect_to :back, flash: {danger: "You are not allowed to delete admins."}
    elsif current_user.admin?
      @user.delete

      redirect_to :back, flash: {success: "User '#{@user.name}' was successfully deleted."}
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
