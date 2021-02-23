class AwaitingReportController < ApplicationController
  def edit
    if current_user.admin?
      @Kit = KitTracker.find(params[:id])
    else
      redirect_to dashboard_index_url
    end
  end

  def submit
    @pdf_information = params[:data]
    render :'awaiting_report/pdf/'
  end
end