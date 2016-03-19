class UsersController < ApplicationController

  before_action :check_if_admin, only: [:index, :new, :edit, :destroy]
  before_action :set_users, only: [:index, :create, :edit, :update, :destroy]
  before_action :find_user, only: [:show, :edit, :update, :destroy]

  def new
    @user = User.new
    @roles = Role.all

    respond_to do |format|
      format.js
    end
  end

  def register
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if current_user && current_user.admin?
      if @user.save
        flash.now[:success] = "#{@user.role.name.capitalize} #{@user.name} successfully created!"
        respond_to { |format| format.js }
      else
        display_errors_for(@user)
        respond_to { |format| format.js }
      end
    else
      if @user.save
        login @user

        redirect_to user_path(@user), flash: {success: "You successfully registered!"}
      else
        display_errors_for(@user)
        render :register
      end
    end
  end

  def edit
    @roles = Role.all

    respond_to { |format| format.js }
  end

  def update
    @roles = Role.all

    if current_user.admin?
      if @user.update(user_params)
        flash.now[:success] = "User #{@user.name} successfully updated!"
        respond_to { |format| format.js }
      else
        display_errors_for(@user)

        render :edit
      end
    end
  end

  def destroy
    if @user.admin?
      flash.now[:danger] = "You are not allowed to delete admins."
    elsif current_user.admin?
      @user.delete

      flash.now[:success] = "User '#{@user.name}' was successfully deleted."
      respond_to {|format| format.js}
    else
      flash.now[:danger] = "You are not allowed to delete users."
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role_id)
  end

  def set_users
    @users = User.order('id DESC')
  end

  def find_user
    @user = User.find(params[:id])
  end
end
