class UsersController < ApplicationController
  before_action :set_user, only: [:show, :destroy]

  def show
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end
end
