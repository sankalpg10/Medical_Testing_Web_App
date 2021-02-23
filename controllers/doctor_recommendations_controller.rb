class DoctorRecommendationsController < ApplicationController

  # before action would override the cancancan RESTful call, permitting parameters to pass
  before_action :new_recommendation, :only => [:create]
#  load_and_authorize_resource

  def index

  end

  def new
    @recommendation = DoctorRecommendation.new
    @recommendations = DoctorRecommendation.all
  end

  def create
    if @recommendation.save
      redirect_to dashboard_index_url, notice: "Referral Successful"
    else
      redirect_to new_doctor_recommendation_path, alert: "Please fill out all the fields"
    end
  end

  def new_recommendation
    @recommendation = DoctorRecommendation.new(safe_params)
  end

  private
  def safe_params
    safe_attributes =
        [
            :first_name,
            :last_name,
            :email,
            :test,
            :message,
            :dr_email
        ]
    params.require(:doctor_recommendation).permit(*safe_attributes)
  end
end
