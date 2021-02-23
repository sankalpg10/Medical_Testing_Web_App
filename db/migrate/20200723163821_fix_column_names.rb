class FixColumnNames < ActiveRecord::Migration[6.0]
  def change
    #   rename_column :kit_id_trackers, :group, :kit_group
    rename_column :order_histories, :group, :kit_group
    rename_column :patient_kits, :group, :kit_group
  end
end
