class MiltsUnseen < ApplicationRecord
  belongs_to :milt
  belongs_to :user

  def self.conversations(conversation, user)
    MiltsUnseen.includes(:milt).where("milt.conversation" => conversation).where(user: user)
  end
end
