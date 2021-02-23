class PatientProfilesController < ApplicationController
  # before action would override the cancancan RESTful call, permitting parameters to pass
  before_action :new_patient_profile, :only => [:create]
#  load_and_authorize_resource

  def index

  end

  def new
    @patient_profile = PatientProfile.new
  end

  def create
    if @patient_profile.save
      redirect_to dashboard_index_url, notice: "Profile Information Saved"
    else
      redirect_to new_patient_profile_path, alert: "Please fill out all the fields"
    end
  end

  def new_patient_profile
    @patient_profile = PatientProfile.new(safe_params)
  end

  private
  def safe_params
    safe_attributes =
        [
            :name,
            :gender,
            :birthdate,
            :phone,
            :email,
            :street,
            :city,
            :zip,
            :doctor
        ]
    params.require(:patient_profile).permit(*safe_attributes)
  end
end
