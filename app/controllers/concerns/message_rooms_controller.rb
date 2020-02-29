module MessageRoomsController
  extend ActiveSupport::Concern

  included do
    def index
    end

    def create
    end

    def destroy
    end

    private

      def set_message_room
        @message_room = MessageRoom.find(params[:id])
      end

      def check_message_room_user_is_current_user
        redirect_to root_url, alert: 'あなたにはこれを行う権限がありません' unless current_user.in?(@message_room.users)
      end
  end
end