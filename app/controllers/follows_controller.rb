class FollowsController < ApplicationController
  def create
    current_user.follow(followable)
  end

  def destroy
    current_user.stop_following(followable)
  end
end
