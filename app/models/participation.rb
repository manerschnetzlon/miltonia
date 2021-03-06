class Participation < ApplicationRecord
  belongs_to :user
  belongs_to :conversation

  validates_uniqueness_of :user_id, scope: :conversation_id
  validates :user, presence: true
end
