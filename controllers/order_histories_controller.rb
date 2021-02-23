class OrderHistoriesController < ApplicationController

  before_action :new_order_history, :only => [:create]
  skip_before_action :authenticate_user!, :only => [:new, :create, :show]

  def index
  end

  def show
    @order_history = OrderHistory.find(params[:id])
  end

  def new
    @order_history = OrderHistory.new
    @patient_kits = PatientKit.all
    @current_kit = PatientKit.find_by_id(1)
    $company = nil
    unless !PatientKit.exists?(params[:id])
      @current_kit = PatientKit.find(params[:id])
    end
    if Company.exists?(company_name: params[:company])
      $company = Company.find_by(company_name: params[:company])
    elsif !params[:company].nil?
      render '/order_histories/new'
    end

      #@company = params[:company]
      #  @order_history.build_user
    # @order_history.user.find_or_create_by(email: params.dig(:user, :email))
  end

  def create
    # @order_history = OrderHistory.new(allowed_params)
    #@order_history.user.find_or_create_by(email: params.dig(:user, :email))
    #check if user is present in system
    check_user = User.find_by email: @order_history.email
    #   logger.debug "User - " + check_user.email
    if check_user.nil?
      logger.debug "YES"
      check_user = User.create(email: @order_history.email)
    end
    @order_history.user_id = check_user.id
    @order_history.update_status_total_cost
    unless @company.nil?
      @order_history.reference = @company.company_name
    end
    if @order_history.save
      #if not present then create user and map to order placed in order history table
      # call method on model to update the status to pending confirmation
      $error = false
      redirect_to @order_history
    else
           $error = true
           redirect_to "/order_histories/new"
    end
  end

  def new_order_history
    @order_history = OrderHistory.new(safe_params)
  end

  private
  def safe_params
    safe_attributes =
        [
            :name, :email, :status, :total_cost, :reference, :quantity, :kit_group, :study, user_attributes: [:email]
        ]
    params.require(:order_history).permit(*safe_attributes)
  end

end
