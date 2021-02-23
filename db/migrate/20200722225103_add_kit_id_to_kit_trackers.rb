class AddKitIdToKitTrackers < ActiveRecord::Migration[6.0]
  def change
    add_column :kit_trackers, :kit_id, :string
    add_index :kit_trackers, [:id, :kit_id], :unique => true
  end
end
