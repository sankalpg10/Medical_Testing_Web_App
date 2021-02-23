class UploadsController < ApplicationController

  before_action :new_upload, :only => [:create]

  def index
    @uploads = current_user.getuploads
  end

  def new
    @upload = Upload.new
  end

  def create
    # check_user = User.find_by email: @upload.email
    # @upload.user_id = check_user.id
    # check_user = current_user.id
    @upload.user_id = current_user.finduser

    if @upload.save
      redirect_to uploads_path, notice: "The upload has been uploaded."
    else
      render "new"
    end

  end

  def destroy
    @upload = Upload.find(params[:id])
    @upload.destroy
    redirect_to uploads_path, notice:  "The upload has been deleted."
  end

  # private
  # def resume_params
  #   params.require(:upload).permit(:email, :attachment, :user_id)
  # end

  def new_upload
    @upload = Upload.new(safe_params)
  end

  private
  def safe_params
    safe_attributes =
        [
            :name, :attachment
        ]
    params.require(:upload).permit(*safe_attributes)
  end
end
