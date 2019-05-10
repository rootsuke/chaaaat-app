class RoomsController < ApplicationController
  before_action :authenticate_user!, only: %i[show]
  def index
    @rooms = Room.all
  end
  
  def show
    @room = Room.find(params[:id])
    @messages = @room.messages.all
  end
end
