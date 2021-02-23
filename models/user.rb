class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  has_one :patient, -> {where role: 'patient'}, class_name: 'Patient'
  has_one :user_detail, -> {where role: 'distributor' or where role: 'admin' or where role: 'doctor' or where role: 'nurse'}, class_name: 'UserDetail'
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  ROLES = %w[patient distributor doctor admin nurse].freeze


  validates :role, inclusion: ROLES

  # send email after creating entry in users table
  after_create :send_admin_mail
  before_validation :check_password

  # association such that a user has many order histories
  has_many :order_histories
  has_many :uploads

  # check!! --> test if send_admin_mail is better than function definition below
  #def send_devise_notification(notification, *args)
  #  devise_mailer.send(notification, self, *args).deliver_later
  #end

  def check_password
    # check if password is empty via bulk upload / or when initial order is placed
    if self.encrypted_password == ""
      user_email = correct_imported_email(self.email)
      self.update_attribute(:email, user_email)
      # set to default password - LabUDefault@123
      self.update_attribute(:encrypted_password, "$2a$12$p3Ocr1/0Xqs2uDLNRovCEutY.TYIF9/d/MBz2OIi.LWh8dAkkhWim")
      LabULog.debug "Created user via excel upload - " + self.email
    end
  end
  # On bulk upload for email, the first string to appear is mailto:, getting rid of that before
  # we save entries into Users table
  def correct_imported_email (user_email)
    if user_email[0..6] == "mailto:"
      temp = user_email.split(':')
      user_email = temp[1]
    end
    user_email
  end

  def send_admin_mail
    UserMailer.send_welcome_email(self).deliver_later
    LabULog.debug 'Added ' + email + ' to LabU system!'
  end

  # method to check if user is patient
  def patient?
    role == 'patient'
  end

  # method to check if user is a doctor
  def doctor?
    role == 'doctor'
  end

  # method to check if user is admin
  def admin?
    role == 'admin'
  end

  # method to check if user is distributor
  def distributor?
    role == 'distributor'
  end

  def finduser
    self.id
  end

  def getuploads
    self.uploads.all
  end

end
