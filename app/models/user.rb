class User < ActiveRecord::Base
  
  has_one  :contact
  
  has_many :messages
  has_many :requests_incomings
  has_many :requests_outcomings
  
end
