class UsersController < ApplicationController  
  include UsersHelper
  before_action :authenticate_user!

  def show
    @user = User.find_by(user_id: params[:user_id])
  end

  def friends
    set_friends_and_requests
  end

  def search
    if params[:search].blank?
      flash[:danger] = "Please enter the user_id."
      redirect_to friends_user_path(current_user.user_id)
    elsif User.exists?(user_id: params[:search])
      redirect_to user_path(params[:search])
    else
      flash.now[:danger] = "Cannot find a user."
      @search_value = params[:search]
      set_friends_and_requests
      render "friends"
    end
  end

  private

    def set_friends_and_requests
      user = User.find_by(user_id: current_user.user_id)
      @users = user.friends.order(name: :asc)
      @friend_requests = FriendRequest.new_request_to(current_user)
    end
end
