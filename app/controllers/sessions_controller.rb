class SessionsController < ApplicationController
  def index;  end

  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      login @user

      redirect_to user_path(@user), flash: {success: "Welcome back, #{current_user.name}"}
    else
      flash.now[:warning] = "Check your email/password"
      render :index
    end

  end

  def destroy
    logout
    redirect_to root_path
  end
end
