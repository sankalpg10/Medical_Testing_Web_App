class CreateOrderHistories < ActiveRecord::Migration[6.0]
  def change
    create_table :order_histories do |t|
      t.string :name
      t.string :email
      t.string :status
      t.float :total_cost
      t.integer :quantity
      t.string :reference

      t.timestamps
    end
  end
end
