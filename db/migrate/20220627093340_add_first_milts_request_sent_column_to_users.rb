class AddFirstMiltsRequestSentColumnToUsers < ActiveRecord::Migration[6.1]
   def change
    add_column :users, :first_milts_request_sent?, :boolean, default: :false
  end
end
