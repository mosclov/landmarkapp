class FollowsLandmarksController < FollowsController
  def followable
    @followable ||= Landmark.find(params[:landmark_id])
  end
end
