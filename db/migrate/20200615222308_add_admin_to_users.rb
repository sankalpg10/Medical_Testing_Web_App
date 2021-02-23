class AddAdminToUsers < ActiveRecord::Migration[6.0]
  def change
    User.create! do |u|
      u.email     = 'admin@labu.com'
      u.password  = 'password@123'
      u.role = 'admin'
    end
  end
end
