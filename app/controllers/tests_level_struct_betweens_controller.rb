require 'uri'
require 'openssl'
class TestsLevelStructBetweensController < ApplicationController


  before_action :set_main_page, only: [:instruction_before_level_body]
  before_action :set_root,      only: [:instruction_before_level_body]
  before_action :set_info,      only: [:instruction_before_level_body]  
#_____________________________________________________________________________________________________________________________________________


  def instruction_before_level_body

    test_url_encoded = params[:details_encoded]
    test_url_json    = Base64.decode64(test_url_encoded)    
    test_url_hash    = JSON.parse(test_url_json)
    
    order_id         = test_url_hash['oi'].to_i    
    order_akey       = test_url_hash['oa']            
    
#______________________________________
    
    
    order            = Order.find(order_id)
    
#______________________________________

  
    if order and order.akey[0..2] == order_akey             

      @root_path = root_path
    
    else   # if order and order.akey[0..2] == order_akey             

#_______________________________________

    
      #security_of_mailing = SecurityOfMailing.new
      #SecureMailer.wrong_url().deliver
      redirect_to root_path + 'info/' + 'dannue_receive_obrabotanu'  
    end   # signal_level_arr.count.in? 1..3
    
  end  

      
#_______________________________________________________________________________      

  
  
  private
  
    def set_main_page
      @main_page  = MainPage.find(1)       
    end    
    def set_root
      root_path   = MeConstant.find_by_title('root_path').content    
    end
    
    def set_info
      @site_title = MeConstant.find_by_title('site_title').content
      @main_page  = MainPage.find(1)   
      
      @page       = Page.find_by_page :test                
    end      
  
end
