class AddUserIdToOrderHistories < ActiveRecord::Migration[6.0]
  def change
    add_column :order_histories, :user_id, :integer
  end
end
