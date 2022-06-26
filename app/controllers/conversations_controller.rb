class ConversationsController < ApplicationController
  def show
    @conversation = Conversation.find(params[:id])
    # @conversation ||= Conversation.find(params[:conversation_id])
    authorize @conversation
    @milts = @conversation.milts.last(50)
    MiltsUnseen.conversations(@conversation, current_user).destroy_all
  end
end
