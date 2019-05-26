# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# users
5.times do |n|
  name = "test_#{n}"
  email = "#{name}@test.com"
  password = "test123"
  User.create!(name:    name,
               user_id: name,
               email:   email,
               password:              password,
               password_confirmation: password)
end

# rooms
5.times do |n|
  name = "room_#{n}"
  Room.create!(name: name)
end

# room_users
users = User.order(:created_at).take(3)
rooms = Room.order(:created_at).take(3)
users.each do |user|
  rooms.each do |room|
    user.join_to_room(room)
  end
end

# friends
user = users.first
user_friends = users[2..3]
user_friends.each do |user_friend|
  user.send_friend_request(user_friend)
  friend_request = FriendRequest.find_by(requester_id: user.id, reciever_id: user_friend.id, approved: false)
  user_friend.approve_friend_request(friend_request)
end
