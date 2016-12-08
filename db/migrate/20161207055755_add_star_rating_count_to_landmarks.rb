class AddStarRatingCountToLandmarks < ActiveRecord::Migration
  def change
    add_column :landmarks, :star_ratings_count, :integer, default: 0
  end
end
