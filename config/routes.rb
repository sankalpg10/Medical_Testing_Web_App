Rails.application.routes.draw do
  resource :awaiting_report
    get 'awaiting_report/edit/:id', to: 'awaiting_report#edit'
    post "/awaiting_report/submit/:id" => "awaiting_report#submit", :as => :submit_form
    get 'awaiting_report/pdf/:id', to: 'awaiting_report#pdf'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  #for doctors
  root 'home#index'
  get 'refer' => 'dashboard#refer'
  get 'doctor_results' => 'dashboard#doctor_results'
  get 'sample_collection' => 'dashboard#sample_collection'
  get 'order_tracking' => 'dashboard#order_tracking'
  get 'catalog' => 'dashboard#catalog'
  get 'payment' => 'dashboard#payment'

  #for telehealth companies
  get 'telehealth_payment' => 'dashboard#telehealth_payment'
  get 'announcement' => 'dashboard#announcement'
  #for patients
  get 'results' => 'dashboard#results'
  get 'patient_order_tracking' => 'dashboard#patient_order_tracking'
  get 'medical_history' => 'dashboard#medical_history'
  get 'education' => 'dashboard#education'

  #for keeping track of referrals
  get 'order_histories/new', to: 'order_histories#new'
  get 'order_histories/new/:id', to: 'order_histories#new'
  get 'order_histories/new/:company', to: 'order_histories#new'
  get 'order_histories/new/:company/:id', to: 'order_histories#new'
  get 'order_histories/new/:company', to: 'order_histories#new'
  resources :dashboard

  resources :doctor_recommendations
  resources :order_histories
  resources :educations
  resources :medical_histories
  resources :telehealth_profiles
  resources :uploads
  resources :patient_profiles
  resources :sample_collections
  # resources :directing do
  #   resources :company
  # end
end

