class AddBooleansToOrderHistory < ActiveRecord::Migration[6.0]
  def change
    add_column :order_histories,  :doctor_referral, :boolean, default: false
    add_column :order_histories, :telehealth_referral, :boolean, default: false
    add_column :order_histories, :distributor_referral, :boolean, default: false
  end
end
