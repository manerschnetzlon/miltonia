class AddMiltCountToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :milts_sent_count, :integer, default: 0
    add_column :users, :milts_received_count, :integer, default: 0
  end
end
