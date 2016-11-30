class Landmark < ActiveRecord::Base
  belongs_to :user
  has_many :reviews, dependent: :destroy
  geocoded_by :address
  after_validation :geocode
end
