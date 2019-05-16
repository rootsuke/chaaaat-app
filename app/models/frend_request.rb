class FrendRequest < ApplicationRecord
  belongs_to :requester, class_name: :User
  belongs_to :reciever,  class_name: :User

  validates :requester_id, presence: true
  validates :reciever_id,  presence: true
end
