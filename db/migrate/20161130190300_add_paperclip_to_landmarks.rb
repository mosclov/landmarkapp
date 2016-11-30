class AddPaperclipToLandmarks < ActiveRecord::Migration
  def change
      add_attachment :landmarks, :image
  end
end
