class HomeController < ApplicationController
  skip_before_action :authenticate_user!, :only => [:index]
  def index
    @tests = PatientKit.all
  end

end
