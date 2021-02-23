class AddGroupToOrderHistories < ActiveRecord::Migration[6.0]
  def change
    add_column :order_histories, :group, :string
  end
end
