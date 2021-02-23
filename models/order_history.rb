class OrderHistory < ApplicationRecord
  belongs_to :user
  accepts_nested_attributes_for :user
  validates_format_of :email,:with => /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/

  STATUS = %w[pending-confirmation confirmed].freeze
  validates :status, inclusion: STATUS

  # delegate in order to access its associated user attributes
  delegate :email, to: :user

  # after saving, update the email field in the order_histories database
  after_save :update_email

  # Since using a nested form, the email in the order_history table is unpopulated
  #   unless we call this method
  def update_email
    self.email = self.user.email
  end

  #update the status to pending confirmation and calculate total cost
  def update_status_total_cost
    total_cost = self.total_cost * self.quantity
    self.status = "pending-confirmation"
    self.update_attribute(:total_cost, total_cost)
  end
end
