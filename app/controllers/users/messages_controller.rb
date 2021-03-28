class Users::MessagesController < ApplicationController
  before_action :authenticate_user!
  # before_action :authenticate_user!, only: [:create]

  def show
    @user = User.find(params[:id])
    # ログインしているユーザーのidが入ったroom_idのみを配列で取得（該当するroom_idが複数でも全て取得）
    rooms = current_user.entries.pluck(:room_id)
    # user_idが@user　且つ　room_idが上で取得したrooms配列の中にある数値のもののみ取得(1個または0個のはずです)
    entries = Entry.find_by(user_id: @user.id, room_id: rooms)

    if entries.nil? # 上記で取得できなかった場合の処理
      # 新しいroomを作成して保存
      @room = Room.new
      @room.save
      # @room.idと@user.idをUserRoomのカラムに保存(１レコード)
      Entry.create(user_id: @user.id, room_id: @room.id)
      # @room.idとcurrent_user.idをUserRoomのカラムに保存(１レコード)
      Entry.create(user_id: current_user.id, room_id: @room.id)
    else
      # 取得している場合は、user_roomsに紐づいているroomテーブルのレコードを@roomに代入
      @room = entries.room
    end
    # if文の中で定義した@roomに紐づくchatsテーブルのレコードを代入
    @messages = @room.messages
    # @room.idを代入したChat.newを用意しておく(message送信時のform用)←筆者の表現が合っているか分かりません、、
    @message = Message.new(room_id: @room.id)
  end


  def create
    @message = current_user.messages.new(message_params)
    @message.save
    # message機能に通知機能を加える際に非同期通信に影響が出る部分
  
    # if Entry.where(user_id: current_user.id, room_id: params[:message][:room_id]).present?
    #   @message = current_user.messages.new(message_params)
    #   @room=@message.room
    #   if @message.save
    #     @room_member=Entry.where(room_id: @room.id).where.not(user_id: current_user.id)

    #     @user_room_id=@room_member.find_by(room_id: @room.id)
    #     notification = current_user.active_notifications.new(
    #       room_id: @message.id,
    #       message_id: @message.id,
    #       visitor_id: current_user.id,
    #       visited_id: @user_room_id.user_id,
    #       action: 'message'
    #       )

    #     if notification.visitor_id == notification.visited_id
    #       notification.checked = true
    #       # 自身のメッセージには通知が届かないよう設定
    #     end
    #     notification.save if notification.valid?
    #   end
    # end
  end

  private

  def message_params
    params.require(:message).permit(:message, :room_id)
  end
end