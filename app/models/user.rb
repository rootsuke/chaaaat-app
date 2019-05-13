class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :messages, dependent: :destroy
  has_many :room_users, dependent: :destroy
  has_many :rooms, through: :room_users

  validates :name, presence: true

  def join_to_room(room)
    self.rooms << room
  end

  def joined?(room)
    self.rooms.include?(room)
  end
end
