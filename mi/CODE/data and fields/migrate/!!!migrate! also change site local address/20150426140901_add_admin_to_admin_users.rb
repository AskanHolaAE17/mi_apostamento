class AddAdminToAdminUsers < ActiveRecord::Migration[5.0]
  
  AdminUser.create!(:email => 'admin@example.com', :password => 'password', :password_confirmation => 'password')   
    
end
