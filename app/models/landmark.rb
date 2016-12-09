class Landmark < ActiveRecord::Base
  acts_as_followable
  has_many :star_ratings
  has_many :reviews, dependent: :destroy
  scope :stars, -> { order(star_ratings_count: :desc).where("star_ratings_count > ?", 0) }
  belongs_to :user
  validates :name, :address, presence: true
  validates :name, uniqueness: true
  geocoded_by :address
  validate :address_is_valid
  has_attached_file :image, styles: { small: "64x64", med: "100x100", large: "200x200" }
  validates_attachment :image, presence: true,
    content_type: { content_type: ["image/jpg", "image/jpeg", "image/png", "image/gif"] },
    size: { in: 0..10.megabytes }

  def address_is_valid
    geocode
    if longitude.nil? || latitude.nil?
      errors.add(:invalid_address, "")
    end
  end

end
