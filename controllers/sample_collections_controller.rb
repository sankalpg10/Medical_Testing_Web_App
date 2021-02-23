class SampleCollectionsController < ApplicationController
  # before action would override the cancancan RESTful call, permitting parameters to pass
  before_action :new_sample_collection, :only => [:create]
#  load_and_authorize_resource

  def index

  end

  def new
    @sample_collection = SampleCollection.new
    @sample_collections = SampleCollection.all
  end

  def create
    if @sample_collection.save
      redirect_to dashboard_index_url, notice: "Successful"
    else
      redirect_to new_sample_collection_path, alert: "Please fill out all the fields"
    end
  end

  def new_sample_collection
    @sample_collection = SampleCollection.new(safe_params)
  end

  private
  def safe_params
    safe_attributes =
        [
            :first_name,
            :last_name,
            :sex,
            :age,
            :mother_last_name,
            :father_last_name,
            :birthday,
            :sampling_date,
            :sampling_time,
            :observations,
            :key_study,
            :study,
            :price,
            :sample_tips
        ]
    params.require(:sample_collection).permit(*safe_attributes)
  end

end
