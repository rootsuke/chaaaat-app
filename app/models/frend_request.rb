class FrendRequest < ApplicationRecord
  belongs_to :reciever,  class_name: :User

  validates :requester_id, presence: true
  validates :reciever_id,  presence: true
end
