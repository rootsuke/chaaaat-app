class UsersController < ApplicationController  
  include UsersHelper
  before_action :authenticate_user!

  def show
    @user = User.find_by(user_id: params[:user_id])
  end

  def friends
    @user = User.find_by(user_id: params[:user_id])
    @users = @user.friends
    @friend_requests = FriendRequest.where(reciever_id: current_user.id, approved: false)
  end
end
