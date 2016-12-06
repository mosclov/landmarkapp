class AddRatingToLandmarks < ActiveRecord::Migration
  def change
    add_column :landmarks, :rating, :string
  end
end
