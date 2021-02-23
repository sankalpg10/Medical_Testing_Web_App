class AddClaveToPatientKits < ActiveRecord::Migration[6.0]
  def change
    add_column :patient_kits, :clave, :string
  end
end
