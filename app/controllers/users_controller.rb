class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :edit,
                                    :update, :destroy, :following, :followers]
  before_action :set_user, only: [:show, :destroy, :following, :followers]



  def show
    @user = User.find(params[:id])
    @landmark = Landmark.new
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

  def follow_landmark
  @user = User.find(params[:id])
  if current_user
    if current_user == @user
      flash[:error] = "You cannot follow yourself."
    else
      current_user.follow(@user)
      RecommenderMailer.new_follower(@user).deliver if @user.notify_new_follower
      flash[:notice] = "You are now following #{@user.monniker}."
    end
  else
    flash[:error] = "You must <a href='/users/sign_in'>login</a> to follow #{@user.monniker}.".html_safe
  end
end

def unfollow_landmark
  @user = User.find(params[:id])

  if current_user
    current_user.stop_following(@user)
    flash[:notice] = "You are no longer following #{@user.monniker}."
  else
    flash[:error] = "You must <a href='/users/sign_in'>login</a> to unfollow #{@user.monniker}.".html_safe
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
