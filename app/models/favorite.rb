class Favorite < ActiveRecord::Base
  belongs_to :user
  belongs_to :landmark
  # validates :user_id, presence: true
  validates :landmark_id, presence: true
  # has_many :active_relationships, class_name:  "Favorite",
  #                                 foreign_key: "fav_user",
  #                                 dependent:   :destroy
  # has_many :favorite, through: :active_relationships,  source:
end
