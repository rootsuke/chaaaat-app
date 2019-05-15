FactoryBot.define do
  factory :frend_request do
    requester_id { 1 }
    reciever_id { 1 }
    approve { false }
  end
end
