class UserSite < ActiveRecord::Base
  
  has_many :users
  has_many :user_personals
  
end
