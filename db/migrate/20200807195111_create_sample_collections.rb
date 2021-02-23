class CreateSampleCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :sample_collections do |t|
      t.string :first_name
      t.string :last_name
      t.string :sex
      t.integer :age
      t.string :mother_last_name
      t.string :father_last_name
      t.string :birthday
      t.string :sampling_date
      t.string :sampling_time
      t.text :observations
      t.string :key_study
      t.string :study

      t.timestamps
    end
  end
end
