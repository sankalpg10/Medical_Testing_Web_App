class MedicalHistoriesController < ApplicationController

  # before action would override the cancancan RESTful call, permitting parameters to pass
  before_action :new_medical_history, :only => [:create]
#  load_and_authorize_resource

  def index

  end

  def new
    @medical_history = MedicalHistory.new
  end

  def create
    if @medical_history.save
      redirect_to dashboard_index_url, notice: "Personal Medical History Saved"
    else
      redirect_to new_medical_history_path, alert: "Please fill out all the fields"
    end
  end

  def new_medical_history
    @medical_history = MedicalHistory.new(safe_params)
  end

  private
  def safe_params
    safe_attributes =
        [
            :age,
            :gender,
            :reasons,
            :personal_history,
            :prior_illness,
            :medication,
            :sti_history,
            :sti,
            :symptoms,
            :symptoms_described,
            :symptom_start_time,
            :obvious_reasons,
            :health_changes,
            :sexual_contact,
            :additional
        ]
    params.require(:medical_history).permit(*safe_attributes)
  end

end
