class SessionsController < ApplicationController
  def index;  end

  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      login @user

      redirect_to user_path(@user), flash: {success: "Welcome, #{current_user.name}"}
    else
      flash.now[:error] = "Check your email/password"
      render :index
    end

  end

  def destroy
    logout
    redirect_to root_path
  end
end
