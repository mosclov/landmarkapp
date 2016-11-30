class Landmark < ActiveRecord::Base
  belongs_to :user
  has_many :reviews
  geocoded_by :address
  after_validation :geocode
end
