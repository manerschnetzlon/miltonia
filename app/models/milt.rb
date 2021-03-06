class Milt < ApplicationRecord
  belongs_to :conversation
  # belongs_to :sender, class_name: 'User', counter_cache: :milts_sent_count
  # belongs_to :receiver, class_name: 'User', counter_cache: :milts_received_count
  belongs_to :sender, class_name: 'User'
  belongs_to :receiver, class_name: 'User'
  has_many :milts_unseens, dependent: :destroy
end
