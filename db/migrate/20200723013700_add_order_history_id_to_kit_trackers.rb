class AddOrderHistoryIdToKitTrackers < ActiveRecord::Migration[6.0]
  def change
    add_column :kit_trackers, :order_history_id, :integer
    add_index :kit_trackers, :order_history_id
  end
end
