class CreateTelehealthProfiles < ActiveRecord::Migration[6.0]
  def change
    create_table :telehealth_profiles do |t|
      t.string :company_name
      t.string :rep_name
      t.string :rep_email
      t.string :contact
      t.string :rep_position
      t.string :address
      t.string :website

      t.timestamps
    end
  end
end
