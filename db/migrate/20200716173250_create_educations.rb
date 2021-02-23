class CreateEducations < ActiveRecord::Migration[6.0]
  def change
    create_table :educations do |t|
      t.string :institution
      t.string :address
      t.string :course
      t.string :duration
      t.string :end_date

      t.timestamps
    end
  end
end
