class PagesController < ApplicationController
  # skip_before_action :authenticate_user!, only: [ :home ]
  def home
    @conversations = current_user.conversations
    @participation = Participation.new
  end
end
