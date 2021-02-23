class CreatePatientKits < ActiveRecord::Migration[6.0]
  def change
    create_table :patient_kits do |t|
      t.string :group
      t.string :study
      t.float :price
      t.text :description

      t.timestamps
    end
  end
end
