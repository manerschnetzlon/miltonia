class MiltsController < ApplicationController
  def create
    conversation = Conversation.find(params[:conversation_id])

    milt = Milt.new(milt_params)
    milt.conversation = conversation
    milt.sender = current_user
    authorize milt

    respond_to do |format|
      format.html do
        if milt.save
          current_user.milts_count -= 1
          render "conversations/show", status: :unprocessable_entity unless current_user.save
          html = render_to_string(partial: "milt", locals: { milt: milt })
          ConversationChannel.broadcast_to(
            conversation, {
              html: html,
              user_id: current_user.id,
              conversation_id: conversation.id
            }
          )
        else
          render "conversations/show", status: :unprocessable_entity
        end
      end
    end
  end

  private

  def milt_params
    params.require(:milt).permit(:receiver_id)
  end
end
