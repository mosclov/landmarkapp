class CreateStarRatings < ActiveRecord::Migration
  def change
    create_table :star_ratings do |t|
      t.integer :rating
      t.references :user, index: true, foreign_key: true
      t.references :landmark, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
