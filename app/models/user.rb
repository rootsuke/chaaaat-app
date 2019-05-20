class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :messages, dependent: :destroy

  has_many :room_users, dependent: :destroy
  has_many :rooms, through: :room_users

  has_many :friend_requests, foreign_key: :requester_id, dependent: :destroy
  has_many :friends, -> { where(friend_requests: { approved: true }) }, through: :friend_requests, source: :reciever

  validates :name, presence: true
  validates :user_id, presence: true, uniqueness: true

  mount_uploader :picture, PictureUploader

  def join_to_room(room)
    self.rooms << room
  end

  def joined?(room)
    self.rooms.include?(room)
  end

  def send_friend_request(user)
    self.friend_requests.create(reciever: user)
  end

  def approve_friend_request(friend_request)
    friend_request.update_attribute(:approved, true)
    self.friend_requests.create(reciever: friend_request.requester, approved: true)
  end
end
