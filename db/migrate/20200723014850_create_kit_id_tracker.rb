class CreateKitIdTracker < ActiveRecord::Migration[6.0]
  def change
    create_table :kit_id_trackers do |t|
        t.string :kit_id
        t.string :clave
        t.string :group
        t.string :study
        t.string :identifier

        t.timestamps
    end
  end
end
