class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def edit
    @user = User.find_by(params[:user_id])
  end

  def update
  if @user.update_attributes(user_params)
    flash[:success] = "Profile Updated"
    redirect_to @user
  else
    render 'edit'
  end
end

  def create
    @user = User.new(user_params)
    if @user.save
      login @user
      flash[:success] = "You did it!!!!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find_by(params[:user_id])
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  private
      def user_params
        params.require(:user).permit(:name, :email, :password, :password_confirmation)
      end

end
