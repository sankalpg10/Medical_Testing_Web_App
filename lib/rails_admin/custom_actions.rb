module RailsAdmin
  module Config
    module Actions
      class UnconfirmedOrders< RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)
        register_instance_option :root do
          true
        end
        register_instance_option :link_icon do
          'fa fa-check'
        end
        register_instance_option :controller do
          Proc.new do
            # fetch all rows with status pending-confirmation
            @data = OrderHistory.where("status = 'pending-confirmation'")
            if request.post?
              unless params[:order_ids].nil?
                @orders = OrderHistory.find(params[:order_ids].map(&:to_i))
                @orders.each do |order|
                  # Iterate over each order, and check if one order has more than 1 kit to be ordered
                  # if an order has 5 kits placed, then 5 separate kits with corresponding kit ids are to be generated
                  1.upto(order.quantity) do
                    kit_id_tracker = KitidTracker.new
                    kit_id_tracker.kit_group = order.kit_group
                    kit_id_tracker.study = order.study

                    # get kit id from method on kitidtracker class
                    k = kit_id_tracker.generate_kit_id order.doctor_referral, order.telehealth_referral, order.distributor_referral
                    #logger.debug "kit id - " + k
                    # Create new instance of kit tracker with newly obtained kit id
                    kit_tracker = KitTracker.new(kit_id: k, order_history_id: order.id, name: order.name, email: order.email, study: order.study, status: "order-placed", date_order_placed: Time.now)

                    # check if doctor has referred the patient, if so add them to kit tracker table
                    if order.doctor_referral?
                      kit_tracker.doctor = order.reference
                    end
                    if kit_tracker.save
                      order.update(:status => 'confirmed')
                    else
                      flash[:error] = "ERROR"
                      redirect_to unconfirmed_orders_path
                    end
                  end
                end
                flash[:notice] = "Confirmed #{@orders.length()} Orders!"
                redirect_to unconfirmed_orders_path
              end
              if params[:order_ids].nil?
                flash[:notice] = "Select atleast one order"
              end
              end
          end
        end
        register_instance_option :http_methods do
          [:get, :post]
        end
      end
      class SampleToTake< RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)
        register_instance_option :root do
          true
        end
        register_instance_option :link_icon do
          'fa fa-check'
        end
        register_instance_option :controller do
          Proc.new do
            @data = KitTracker.where("status = 'order-placed'")
            if request.post? # EDIT
              unless params[:order_ids].nil?
                @orders = KitTracker.find(params[:order_ids].map(&:to_i))
                @orders.each do |order|
                  order.update(:status => 'sample-taken')
                  order.update(:date_sample_taken => Time.now)
                end
                flash[:notice] = "Updated #{@orders.length()} Orders!"
                redirect_to sample_to_take_path
              end
              if params[:order_ids].nil?
                flash[:notice] = "Select atleast one order"
              end
            end
          end
        end
        register_instance_option :http_methods do
          [:get, :post]
        end
      end

      class SampleToLab< RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)
        register_instance_option :root do
          true
        end
        register_instance_option :link_icon do
          'fa fa-check'
        end
        register_instance_option :controller do
          Proc.new do
            @data = KitTracker.where("status = 'sample-taken'")
            if request.post? # EDIT
              unless params[:order_ids].nil?
                @orders = KitTracker.find(params[:order_ids].map(&:to_i))
                @orders.each do |order|
                  order.update(:status => 'report-pending')
                  order.update(:date_sample_sent => Time.now)
                end
                flash[:notice] = "Updated #{@orders.length()} Orders!"
                redirect_to sample_to_lab_path
              end
              if params[:order_ids].nil?
                flash[:notice] = "Select at least one order"
              end
            end
          end
        end
        register_instance_option :http_methods do
          [:get, :post]
        end
      end

      class SampleAwaitingReport< RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)
        register_instance_option :root do
          true
        end
        register_instance_option :link_icon do
          'fa fa-check'
        end
        register_instance_option :controller do
          Proc.new do
            @data = KitTracker.where("status = 'report-pending'")
            if request.post? # EDIT
              unless params[:order_ids].nil?
                @orders = KitTracker.find(params[:order_ids].map(&:to_i))
                @orders.each do |order|
                  order.update(:status => 'complete')
                  order.update(:date_report_pending => Time.now)
                  order.update(:date_complete => Time.now)
                end
                flash[:notice] = "Updated #{@orders.length()} Orders!"
                redirect_to sample_awaiting_report_path
              end
              if params[:order_ids].nil?
                flash[:notice] = "Select at least one order"
              end
            end
          end
        end
        register_instance_option :http_methods do
          [:get, :post]
        end
      end
      class CompletedOrders< RailsAdmin::Config::Actions::Base
        RailsAdmin::Config::Actions.register(self)
        register_instance_option :root do
          true
        end
        register_instance_option :link_icon do
          'fa fa-check'
        end
        register_instance_option :controller do
          Proc.new do
            @data = KitTracker.where("status = 'complete'")
          end
        end
      end
    end
  end
end
