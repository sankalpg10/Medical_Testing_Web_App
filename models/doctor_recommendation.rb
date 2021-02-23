class DoctorRecommendation < ApplicationRecord
#  attr_accessor :first_name, :last_name, :email, :test, :message, :created_at, :updated_at
  validates :first_name, :last_name, :email, :test, :presence => true
end
