class MiltsController < ApplicationController
  def create
    conversation = Conversation.find(params[:conversation_id])

    milt = Milt.new(milt_params)
    milt.conversation = conversation
    milt.sender = current_user
    authorize milt

    respond_to do |format|
      if milt.save
        MiltsUnseen.conversations(conversation, current_user).destroy_all
        MiltsUnseen.create(user: current_user.correspondant(conversation), milt: milt)
        format.html do
          current_user.milts_count -= 1
          render "conversations/show", status: :unprocessable_entity unless current_user.save
          partial_receiver_conversations = render_to_string(partial: "conversations", locals: { conversations: conversation.correspondant(current_user).conversations.ordered_by_time, current_user: conversation.correspondant(current_user), user: current_user })
          partial_milt = render_to_string(partial: "milt", locals: { milt: milt })
          partial_milts_count = render_to_string(partial: "counter_milts", locals: { current_user: current_user })
          partial_footer = render_to_string(partial: "footer_show", locals: { current_user: current_user, conversation: conversation, milt: milt })
          ConversationChannel.broadcast_to(
            conversation, {
              milt: partial_milt,
              milts_count: partial_milts_count,
              # sender_conversations: sender_conversations,
              receiver_conversations: partial_receiver_conversations,
              footer: partial_footer,
              correspondant_id: current_user.correspondant(conversation).id,
              user_id: current_user.id,
              conversation_id: conversation.id
            }
          )
        end
        format.json
      else
        format.html { render "conversations/show", status: :unprocessable_entity, locals: { current_user: current_user, conversation: Conversation.find(params[:conversation_id]), milt: Milt.new } }
        format.json
      end
    end
  end

  def add_received_milts
    current_user.savings_count = current_user.savings_count + current_user.milts_received_count
    current_user.milts_received_count = 0
    respond_to do |format|
      respond_to_when_add_milts(format)
    end
  end

  def add_sent_milts
    current_user.savings_count = current_user.savings_count + current_user.milts_sent_count
    current_user.milts_sent_count = 0
    respond_to do |format|
      respond_to_when_add_milts(format)
    end
  end

  private

  def respond_to_when_add_milts(format)
    if current_user.save
      format.html { redirect_to insight_path }
      format.json
    else
      format.html { render "pages/insight", status: :unprocessable_entity }
      format.json
    end
  end

  def milt_params
    params.require(:milt).permit(:receiver_id)
  end
end
