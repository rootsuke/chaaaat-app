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

  validates :name, presence: true, length: { maximum: 20 }
  validates :user_id, presence: true, uniqueness: true, length: { maximum: 15 }
  validate  :icon_size

  mount_uploader :icon, UserIconUploader

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

  def delete_from_friends(user)
    FriendRequest.where(requester_id: self.id, reciever_id: user.id).
      or(FriendRequest.where(requester_id: user.id, reciever_id: self.id)).
        each { |f| f.destroy }
  end

  def friend?(user)
    self.friends.include?(user)
  end

  def waiting_for_approval?(user)
    self.friend_requests.exists?(reciever_id: user.id, approved: false)
  end

  def recieved_request_from?(user)
    user.friend_requests.exists?(reciever_id: self.id, approved: false)
  end

  private

    def icon_size
      if icon.size > 5.megabytes
        errors.add(:icon, "should be less than 5MB")
      end
    end
end
