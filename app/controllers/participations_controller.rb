class ParticipationsController < ApplicationController
  def create
    conversation = find_conversation
    if conversation.nil?
      conversation = Conversation.new
      something_went_wrong unless conversation.save
      current_user_p = Participation.new(conversation: conversation, user: current_user)
      other_user_p = Participation.new(conversation: conversation,
                                       user: User.find(params[:participation][:user_id]))
      something_went_wrong unless current_user_p.save && other_user_p.save
    end
    authorize conversation
    redirect_to conversation_path(conversation)
  end

  private

  def something_went_wrong
    redirect_to home_path, flash: { error: "Something went wrong..." }
  end

  def find_conversation
    current_user_conversation = Conversation.includes(:participations).where("participations.user" => current_user)
    other_user_conversation = Conversation.includes(:participations).where("participations.user" => params[:participation][:user_id])
    (current_user_conversation & other_user_conversation).first
  end
end
