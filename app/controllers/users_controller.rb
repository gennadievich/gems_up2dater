class UsersController < ApplicationController
  USERS_PER_PAGE = 13

  before_action :check_if_admin, only: [:index, :new, :edit, :destroy]

  def index
    @users = User.order('id DESC')
  end

  def show
    @user = User.find(params[:id])
  end

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
    @users = User.order('id DESC')
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
    @user = User.find(params[:id])
    @roles = Role.all
    @users = User.order('id DESC')

    respond_to { |format| format.js }
  end

  def update
    @user = User.find(params[:id])
    @roles = Role.all
    @users = User.order('id DESC')

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
    @users = User.order('id DESC')
    @user = User.find(params[:id])

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
end
