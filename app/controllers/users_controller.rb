class UsersController < ApplicationController  
  before_action :authenticate_user!

  def show
    @user = User.find_by(user_id: params[:user_id])
  end
end
