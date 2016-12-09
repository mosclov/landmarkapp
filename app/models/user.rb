class User < ActiveRecord::Base
    acts_as_follower
    # added has many favorites
    has_many :favorites
    has_many :favorited, through: :favorites, source: :landmark
    has_many :star_ratings
    has_many :landmarks
    has_many :reviews, dependent: :destroy
    has_many :active_relationships, class_name:  "Relationship",
                                    foreign_key: "follower_id",
                                    dependent:   :destroy
    has_many :passive_relationships, class_name:  "Relationship",
                                    foreign_key: "followed_id",
                                    dependent:   :destroy
    has_many :following, through: :active_relationships,  source: :followed
    has_many :followers, through: :passive_relationships, source: :follower
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
           :recoverable, :rememberable, :trackable, :validatable, :omniauthable, :omniauth_providers => [:facebook]


  def feed
    following_ids_subselect = "SELECT followed_id FROM relationships
                               WHERE  follower_id = :user_id"
    Review.where("user_id IN (#{following_ids_subselect})
                     OR user_id = :user_id", user_id: id)
  end


   def follow(other_user)
     active_relationships.create(followed_id: other_user.id)
   end

   def favorite(landmark)
     active_relationships.create(landmark_id: other_user.id)
   end


   def unfollow(other_user)
     active_relationships.find_by(followed_id: other_user.id).destroy
   end


   def following?(other_user)
     following.include?(other_user)
   end

    def self.from_omniauth(auth)
      where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0,20]
      # user.image = auth.info.image # assuming the user model has an image
    end

  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end



  # Follows a user.
  def add_favorite(landmark)
    favorites.create(landmark_id: landmark.id)
  end

  def remove_favorite(landmark)
    favorites.find_by(landmark_id: landmark.id).destroy
  end

  # Returns true if the current user is following the other user.
  def favorited?(landmark)
    favorited.include?(landmark)
  end


end
