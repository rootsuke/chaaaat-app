class UsersController < ApplicationController  
  include UsersHelper
  before_action :authenticate_user!

  def show
    @user = User.find_by(user_id: params[:user_id])
  end

  def friends
    @user = User.find_by(user_id: params[:user_id])
    @users = @user.friends.order(name: :asc)
    @friend_requests = FriendRequest.new_request_to(current_user)
  end
end
