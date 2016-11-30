class Review < ActiveRecord::Base
  belongs_to :landmark
  belongs_to :user
end
