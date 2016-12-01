class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:show, :destroyils]


  def show
    @user = User.find(params[:id])
    @landmark = Landmark.new
    if @user.id != current_user.id
      flash[:alert] = "Can't go into others profile!"
      redirect_to '/'
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
