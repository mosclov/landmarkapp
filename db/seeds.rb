# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

60.times do |i|
  User.create!(
    email: Faker::Internet.user_name + i.to_s + "@#{Faker::Internet.domain_name}",
    password: 'password'
  )
end

30.times do |i|
Landmark.create!(
  name: Faker::Commerce.department + Faker::Commerce.color,
  description: Faker::ChuckNorris.fact,
  address: '1550 Market St. San Diego, CA',
  website: Faker::Internet.url,
  image: Faker::Placeholdit.image,
  user_id:  Faker::Number.between(1, 60)
)
end

350.times do |i|
  StarRating.create!(
    rating: Faker::Number.between(1, 5),
    user_id: Faker::Number.between(1, 60),
    landmark_id: Faker::Number.between(1, 30)
  )
end

175.times do |i|
  Review.create!(
  text: Faker::Hipster.sentence,
  user_id: Faker::Number.between(1, 60),
  landmark_id: Faker::Number.between(1, 30)
  )
end

users = User.all
user  = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }

30.times do |i| Landmark.create!(
  name: Faker::Commerce.department + Faker::Commerce.color, description: Faker::ChuckNorris.fact,
  address: '1550 Market St. San Diego, CA',
  criteria: Faker::Superhero.power,
  image: Faker::Placeholdit.image,
  user_id: Faker::Number.between(1, 60) )
end

landmarks = Landmark.all
favorites = landmarks[2..20]

favorites.each { |landmark| user.add_favorite(landmark)}
