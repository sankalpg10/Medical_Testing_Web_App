class CreateKitTracker < ActiveRecord::Migration[6.0]
  def change
    create_table :kit_trackers do |t|
      t.string :name
      t.string :email
      t.string :study
      t.string :status
      t.string :doctor
      t.datetime :date_order_placed
      t.datetime :date_sample_taken
      t.datetime :date_sample_sent
      t.datetime :date_report_pending
      t.datetime :date_complete
    end
  end
end
