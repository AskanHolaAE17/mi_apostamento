class User < ActiveRecord::Base
  
  has_one  :contact
  has_one  :room
  
  has_many :messages
  has_many :requests_for_communications
  has_many :show_feedback_requests    
  
end
