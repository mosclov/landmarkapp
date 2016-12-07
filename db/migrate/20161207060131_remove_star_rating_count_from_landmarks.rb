class RemoveStarRatingCountFromLandmarks < ActiveRecord::Migration
  def change
    remove_column :landmarks, :star_rating_count, :integer
  end
end
