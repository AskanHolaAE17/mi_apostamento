# encoding: utf-8
class OrderInfoPagesController < ApplicationController

  before_action :set_pages_and_order_info_page, :set_site_title,  only: [:show]

  def show
    @root_path    = MeConstant.find_by_title('root_path').content      
  end
#_____________________________________________________________________________________________________________________________________________

  
    
  private
  
    
    def set_pages_and_order_info_page
      @page       = Page.find_by_page :info
      @main_page  = MainPage.find(1)       
  
      msg         = params[:msg]    
      order_info_page = OrderInfoPage.find_by translit: msg 
      
      
      if order_info_page
        @info_msg   = order_info_page.msg 
      else      # if Error ( info_msg - undefined )
              
        error_request = 'info/' + msg
        details = "' " + 'Failed trying to find OrderInfoPage by tranclit: ' + msg + " (request: #{error_request})" + " '"  #details for Secure Email.
        @info_msg = 'Запрос обрабатывается. Спасибо'                            # Snag for Fraud ( обманка обманщику ).
        
        
        
        error_in_db = SecurityOfMailing.where( error_type: 'Undefined in DataBase' )   # try to find Exist Error Event ( from early fraud ).
        error_in_db = error_in_db.where( error_request: error_request ) if error_in_db
        error_in_db = error_in_db.first
        
        
        if error_in_db                                                          # if Error Event exists in db.                              
          if (Time.now.utc - error_in_db.when_starts_new_counter.to_time.utc) / 1.hours >= 24  # check: does need reset counter                                                  
            error_in_db.counter = 0 
            error_in_db.when_starts_new_counter = DateTime.now.utc
          end
        else            # unless Error Event exists in db
        
          error_in_db = SecurityOfMailing.new( error_type: 'Undefined in DataBase', error_request: error_request, error_message: details.gsub("'", ""), counter: 0, when_starts_new_counter: DateTime.now.utc )
        end                
        
        
        error_in_db.counter += 1                                            # increment Counter (number tries [try + es])                          
                
        error_in_db.save
                  
        if error_in_db.counter < 4                                            # send Secury Email only if thats 
          id_for_email_theme_string_begin = error_in_db.id
          SecureMailer.undefined_in_db(details, error_in_db.counter, id_for_email_theme_string_begin).deliver                       # not Avalanche ( лавина/шквал [Авэлаанч] ).          
        end                         
          
      end            ## END: if Error ( info_msg - undefined )
    end  
    
    
    def set_site_title 
      @site_title = MeConstant.find_by_title('site_title').content          
    end                                                 
    
end
