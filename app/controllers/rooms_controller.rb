class RoomsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :joined_user?, only: %i(edit update)

  def index
    @rooms = Room.all
    if user_signed_in?
      @room = Room.new
    end
  end

  def create
    @room = Room.create(room_params)
    if @room.save
      flash[:success] = "room created!"
      current_user.join_to_room(@room)
      redirect_to root_url
    else
      @rooms = Room.all
      render "rooms/index"
    end
  end

  def show
    @room = Room.find(params[:id])
    unless current_user.joined?(@room)
      current_user.join_to_room(@room)
    end
    @messages = @room.messages.includes(:user)
  end

  def members
    @room = Room.find(params[:id])
    @users = @room.users
  end

  def edit
    @room = Room.find(params[:id])
  end

  def update
    if @room.update_attributes(room_params)
      flash[:success] = "Successfully updated room"
      redirect_to room_path(@room)
    else
      render "edit"
    end
  end

  private

    def room_params
      params.require(:room).permit(:name, :icon)
    end

    def joined_user?
      @room = Room.find(params[:id])
      redirect_to root_url unless current_user.joined?(@room)
    end
end
