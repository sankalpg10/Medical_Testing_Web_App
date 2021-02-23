class KitTracker < ApplicationRecord

  has_many :order_histories

  #different status's for the lifecycle of kit
  STATUS = %w[order-placed sample-taken sample-sent report-pending complete].freeze
  validates :status, inclusion: STATUS


end
