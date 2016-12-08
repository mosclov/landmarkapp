class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :edit,
                                    :update, :destroy, :following, :followers]
  before_action :set_user, only: [:show, :destroy, :following, :followers]



  def show
    @user = User.find(params[:id])
    @landmark = Landmark.new
    # @favorite = Favorite.new


    @feed_items = current_user.feed.paginate(:page => params[:page], :per_page => 10)
    # if @user.id != current_user.id
    #   flash[:alert] = "Can't go into others profile!"
    #   redirect_to '/'
    # end
  end

  def following
    @user = User.find(params[:id])
    @users = @user.following.paginate(:page => params[:page])
    render 'show_follow'
  end

  def followers
    @user = User.find(params[:id])
    @users = @user.followers.paginate(:page => params[:page])
    render 'show_follow'
  end



  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

end
