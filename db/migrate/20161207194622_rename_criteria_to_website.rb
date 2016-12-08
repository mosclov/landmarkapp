class RenameCriteriaToWebsite < ActiveRecord::Migration
  def change
    rename_column :landmarks, :criteria, :website
  end
end
