class UsersController < ApplicationController
  USERS_PER_PAGE = 10

  before_action :check_if_admin, only: [:index, :new, :edit, :destroy]

  def index
    @users = User.paginate(:page => params[:page], :per_page => USERS_PER_PAGE).order('id ASC')
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
    @roles = Role.all
  end

  def register
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if current_user && current_user.admin?
      if @user.save
        redirect_to users_path, flash: {success: "#{@user.role.name.capitalize} #{@user.name} successfully created!"}
      else
        display_errors_for(@user)
        render :register
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
  end

  def update
    @user = User.find(params[:id])
    @roles = Role.all

    if current_user.admin?
      if @user.update(user_params)
        redirect_to users_path, flash: {success: "User #{@user.name} successfully updated!"}
      else
        display_errors_for(@user)
        render :edit
      end
    end
  end

  def destroy
    @user = User.find(params[:id])

    if @user.admin?
      redirect_to :back, flash: {danger: "You are not allowed to delete admins."}
    elsif current_user.admin?
      @user.delete

      redirect_to :back, flash: {success: "User '#{@user.name}' was successfully deleted."}
    else
      redirect_to :back, flash: {danger: "You are not allowed to delete users."}
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation, :role_id)
  end
end
