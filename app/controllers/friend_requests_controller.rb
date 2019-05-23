class FriendRequestsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    user = User.find(params[:reciever_id])
    current_user.send_friend_request(user)
    redirect_to user_path(user.user_id)
  end

  def destroy
    user = User.find(params[:friend_id])
    current_user.delete_from_friends(user)
    redirect_to user_path(user.user_id)
  end

  def update
    friend_request = FriendRequest.find(params[:id])
    current_user.approve_friend_request(friend_request)
    redirect_to friends_user_path(current_user.user_id)
  end
end
