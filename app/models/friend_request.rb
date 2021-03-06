class FriendRequest < ApplicationRecord
  belongs_to :requester, class_name: :User
  belongs_to :reciever,  class_name: :User

  validates :requester_id, presence: true
  validates :reciever_id,  presence: true

  scope :new_request_to, -> (user) do
    where(reciever_id: user.id, approved: false).includes(:requester)
  end
end
