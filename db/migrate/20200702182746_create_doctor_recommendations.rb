class CreateDoctorRecommendations < ActiveRecord::Migration[6.0]
  def change
    create_table :doctor_recommendations do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :test
      t.text :message
      t.timestamps null: false
    end
  end
end
