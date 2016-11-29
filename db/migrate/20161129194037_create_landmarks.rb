class CreateLandmarks < ActiveRecord::Migration
  def change
    create_table :landmarks do |t|
      t.string :name
      t.text :description
      t.string :address
      t.string :criteria
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
