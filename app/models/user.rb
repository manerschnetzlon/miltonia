class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :participations
  has_many :conversations, through: :participations
  has_many :milts, foreign_key: 'sender_id'
  has_many :milts, foreign_key: 'receiver_id'
  has_many :milts_unseens, dependent: :destroy
  has_many :milts_requests, dependent: :destroy

  validates :pseudo, uniqueness: true

  def correspondant(conversation)
    conversation.users.where.not(id: self.id).first
  end

  # def correspondants
  #   conversations.ordered_by_time.map { |conv| conv.correspondant(self) }
  # end

  # def correspondants_of_correspondants
  #   correspondants.map(&:correspondants).flatten
  # end
end
