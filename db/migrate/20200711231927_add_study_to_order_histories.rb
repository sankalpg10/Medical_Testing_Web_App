class AddStudyToOrderHistories < ActiveRecord::Migration[6.0]
  def change
    add_column :order_histories, :study, :string
  end
end
