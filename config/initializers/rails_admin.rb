require_relative '' '../../lib/rails_admin/custom_actions.rb'

RailsAdmin.config do |config|
  ### Popular gems integration

  ## == Devise ==
  config.authenticate_with do
    warden.authenticate! scope: :user
  end
  config.current_user_method(&:current_user)

  ## == CancanCan ==
  config.authorize_with :cancancan

  ## == Pundit ==
  # config.authorize_with :pundit

  ## == PaperTrail ==
  # config.audit_with :paper_trail, 'User', 'PaperTrail::Version' # PaperTrail >= 3.0.0

  ### More at https://github.com/sferik/rails_admin/wiki/Base-configuration

  ## == Gravatar integration ==
  ## To disable Gravatar integration in Navigation Bar set to false
  # config.show_gravatar = true

  config.actions do
    dashboard                     # mandatory
    index                         # mandatory
    unconfirmed_orders
    sample_to_take
    sample_to_lab
    sample_awaiting_report
    completed_orders
    new
    export
    bulk_delete
    show
    edit
    delete
    show_in_app
    all
      #import
    ## With an audit adapter, you can add:
    # history_index
    # history_show
  end
end
