class StarRating < ActiveRecord::Base
  belongs_to :user
  belongs_to :landmark, :counter_cache => true
  validates :user, :landmark, presence: true
  validates :rating, presence: true
end
