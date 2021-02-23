class CreateUserDetails < ActiveRecord::Migration[6.0]
  def change
    create_table :user_details do |t|
      t.string :email
      t.string :telephone
      t.string :name
      t.datetime :dob
      t.text :address1
      t.text :address2
      t.string :gender

      t.timestamps
    end
  end
end
