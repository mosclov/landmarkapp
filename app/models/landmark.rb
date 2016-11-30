class Landmark < ActiveRecord::Base
  belongs_to :user
  validates :name, :address, presence: true
  validates :name, uniqueness: true
  geocoded_by :address
  validate :address_is_valid

  def address_is_valid
    geocode
    if longitude.nil? || latitude.nil?
      errors.add(:invalid_address, "")
    end
  end

end
