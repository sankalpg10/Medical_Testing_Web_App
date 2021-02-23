class CreateMedicalHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :medical_histories do |t|
      t.integer :age
      t.string :gender
      t.text :reasons
      t.string :personal_history
      t.string :prior_illness
      t.string :medication
      t.string :sti_history
      t.string :sti
      t.string :symptoms
      t.text :symptoms_described
      t.string :symptom_start_time
      t.text :obvious_reasons
      t.string :health_changes
      t.string :sexual_contact
      t.text :additional

      t.timestamps
    end
  end
end
