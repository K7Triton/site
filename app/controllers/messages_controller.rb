class MessagesController < ApplicationController

  def new
    @friend_id = params[:friend_id]
    @active = Message.where(:user_id => current_user.id, :friend_id => @friend_id)
    @passive = Message.where(:user_id => @friend_id, :friend_id => current_user.id )
    @allmessages = @active | @passive
  end



  def create
    @messages = Message.new(new_params)
    if @messages.save
      redirect_to :back
    end
end

  private

  def new_params
    params.require(:message).permit(:user_id, :friend_id, :text)
  end

end
