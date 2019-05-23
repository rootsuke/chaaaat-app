class Room < ApplicationRecord
  has_many :messages, dependent: :destroy
  has_many :room_users, dependent: :destroy
  has_many :users, through: :room_users

  validates :name, presence: true
  validate  :icon_size

  mount_uploader :icon, RoomIconUploader

  private
  
    def icon_size
      if icon.size > 5.megabytes
        errors.add(:icon, "should be less than 5MB")
      end
    end
end
