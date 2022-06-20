class MiltsController < ApplicationController
  def create
    conversation = Conversation.find(params[:conversation_id])

    milt = Milt.new(milt_params)
    milt.conversation = conversation
    milt.sender = current_user
    authorize milt

    respond_to do |format|
      if milt.save
        format.html do
          current_user.milts_count -= 1
          render "conversations/show", status: :unprocessable_entity unless current_user.save
          # sender_conversations = render_to_string(partial: "conversations", locals: { conversations: current_user.conversations.ordered_by_time, user: current_user })
          receiver_conversations = render_to_string(partial: "conversations", locals: { conversations: conversation.correspondant(current_user).conversations.ordered_by_time, user: conversation.correspondant(current_user) })
          milt = render_to_string(partial: "milt", locals: { milt: milt })
          milts_count = render_to_string(partial: "counter_milts", locals: { current_user: current_user })
          ConversationChannel.broadcast_to(
            conversation, {
              milt: milt,
              milts_count: milts_count,
              # sender_conversations: sender_conversations,
              receiver_conversations: receiver_conversations,
              user_id: current_user.id,
              conversation_id: conversation.id
            }
          )
        end
        format.json
      else
        format.html { render "conversations/show", status: :unprocessable_entity }
        format.json
      end
    end

    # respond_to do |format|
    #   format.html do
    #     if milt.save
    #       current_user.milts_count -= 1
    #       render "conversations/show", status: :unprocessable_entity unless current_user.save
    #       html = render_to_string(partial: "milt", locals: { milt: milt })
    #       html2 = render_to_string(partial: "counter_milts", locals: { current_user: current_user })
    #       ConversationChannel.broadcast_to(
    #         conversation, {
    #           html: html,
    #           html2: html2,
    #           user_id: current_user.id,
    #           conversation_id: conversation.id
    #         }
    #       )
    #     else
    #       render "conversations/show", status: :unprocessable_entity
    #     end
    #   end
    # end
  end

  private

  def milt_params
    params.require(:milt).permit(:receiver_id)
  end
end
