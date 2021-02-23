class TelehealthProfilesController < ApplicationController

  # before action would override the cancancan RESTful call, permitting parameters to pass
  before_action :new_telehealth_profile, :only => [:create]
#  load_and_authorize_resource

  def index

  end

  def new
    @telehealth_profile = TelehealthProfile.new
  end

  def create
    if @telehealth_profile.save
      redirect_to dashboard_index_url, notice: "Profile Information Saved"
    else
      redirect_to new_telehealth_profile_path, alert: "Please fill out all the fields"
    end
  end

  def new_telehealth_profile
    @telehealth_profile = TelehealthProfile.new(safe_params)
  end

  private
  def safe_params
    safe_attributes =
        [
            :company_name,
            :rep_name,
            :rep_email,
            :contact,
            :rep_position,
            :address,
            :website
        ]
    params.require(:telehealth_profile).permit(*safe_attributes)
  end

end
