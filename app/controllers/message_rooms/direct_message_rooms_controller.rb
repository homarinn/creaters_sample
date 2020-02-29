class MessageRooms::DirectMessageRoomsController < ApplicationController
  include MessageRoomsController

  before_action :authenticate_user!, only: [:index, :create, :destroy]
  before_action :check_message_room_user_is_current_user, only: :destroy

  def index
  end

  def create
  end

  def destroy
  end

  private
end
