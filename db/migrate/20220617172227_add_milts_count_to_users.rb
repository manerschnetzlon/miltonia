class AddMiltsCountToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :milts_count, :integer, default: 21
  end
end
