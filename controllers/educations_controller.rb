class EducationsController < ApplicationController

  # before action would override the cancancan RESTful call, permitting parameters to pass
  before_action :new_education, :only => [:create]
#  load_and_authorize_resource

  def new
    @education = Education.new
  end

  def index

  end

  def create
    if @education.save
      redirect_to dashboard_index_url, notice: "Education Saved"
    else
      redirect_to new_education_path, alert: "Please fill out all the fields"
    end
  end

  def new_education
    @education = Education.new(safe_params)
  end

  private
  def safe_params
    safe_attributes =
        [
            :institution,
            :address,
            :course,
            :duration,
            :end_date
        ]
    params.require(:education).permit(*safe_attributes)
  end
end
