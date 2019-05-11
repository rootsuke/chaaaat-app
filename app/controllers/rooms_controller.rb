class RoomsController < ApplicationController
  before_action :authenticate_user!, only: %i[show create]
  def index
    @rooms = Room.all
    if user_signed_in?
      @room = Room.new
    end
  end

  def create
    room = Room.create(room_params)
    if room.save
      flash[:success] = "room created!"
      redirect_to root_url
    else
      render "rooms/index"
    end
  end
  
  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.all
  end

  private
  
    def room_params
      params.require(:room).permit(:name)
    end
end
