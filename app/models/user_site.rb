class UserSite < ActiveRecord::Base
  
  has_many :users
  has_many :user_personal_consults
  
end
