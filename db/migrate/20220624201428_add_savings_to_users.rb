class AddSavingsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :savings_count, :integer, default: 0
  end
end
