class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :messages, dependent: :destroy

  has_many :room_users, dependent: :destroy
  has_many :rooms, through: :room_users

  has_many :frend_requests, foreign_key: :requester_id, dependent: :destroy
  has_many :frends, -> { where(frend_requests: { approved: true }) }, through: :frend_requests, source: :reciever

  validates :name, presence: true
  validates :user_id, presence: true, uniqueness: true

  def join_to_room(room)
    self.rooms << room
  end

  def joined?(room)
    self.rooms.include?(room)
  end

  def send_frend_request(user)
    self.frend_requests.create(reciever: user)
  end

  def approve_frend_request(frend_request)
    frend_request.update_attribute(:approved, true)
    self.frend_requests.create(reciever: frend_request.requester, approved: true)
  end
end
