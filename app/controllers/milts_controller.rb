class MiltsController < ApplicationController
  def create
    milt = Milt.new(milt_params)
    conversation = Conversation.find(params[:conversation_id])
    milt.conversation = conversation
    milt.sender = current_user
    authorize milt
    if milt.save
      ConversationChannel.broadcast_to(
        conversation,
        render_to_string(partial: "milt", locals: { milt: milt })
      )
      redirect_to conversation_path(conversation, anchor: "milt-#{milt.id}")
    else
      render "conversations/show", status: :unprocessable_entity
    end
  end

  private

  def milt_params
    params.require(:milt).permit(:receiver_id)
  end
end
