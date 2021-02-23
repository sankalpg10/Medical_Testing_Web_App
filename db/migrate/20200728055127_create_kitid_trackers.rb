class CreateKitidTrackers < ActiveRecord::Migration[6.0]
  def change
    create_table :kitid_trackers do |t|
      t.string :kit_id
      t.string :clave
      t.string :kit_group
      t.string :study
      t.string :identifier

      t.timestamps
    end
  end
end
