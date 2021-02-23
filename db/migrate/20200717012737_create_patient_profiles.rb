class CreatePatientProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :patient_profiles do |t|
      t.string :name
      t.string :gender
      t.string :birthdate
      t.string :phone
      t.string :email
      t.string :street
      t.string :city
      t.string :zip
      t.string :doctor

      t.timestamps
    end
  end
end
