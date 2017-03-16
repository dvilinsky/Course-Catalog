class SessionsController < ApplicationController

  def new
  end

  #creates a new sessio when the user logs in
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    #does the user exist and do we have the right password?
    success = user && user.authenticate(params[:session][:password])
    if success
      login user
      if params[:session][:remember_me] == '1'
        remember user
      else
        forget(user)
      end
      redirect_back_or user
    else
      flash.now[:danger] = "Invalid email or password"
      render 'new'
    end
  end

  def destroy
    logout if logged_in?
    redirect_to root_path
  end
end
