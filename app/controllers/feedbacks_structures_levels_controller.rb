# encoding: utf-8
class FeedbacksStructuresLevelsController < ApplicationController



  def show
    
    @main_page  = MainPage.find(1)       
    @page       = Page.find_by_page :reco

    @struct_info = 'Запрос выполняется'
    @level_info  = ''
    
  
    details_64   = params[:details]
    details      = Base64.decode64 details_64
    det_arr      = details_from_url_to_array(details, false)
    
    user_id      = det_arr[0]
    user         = User.find(user_id)        
        
    
    if user      
      user_id_in_base       = user.id_in_base.to_s
      user_iib_last_compare = user_id_in_base.length - 1
      user_code_compare     = user_id_in_base[user_iib_last_compare - 1] + user_id_in_base[user_iib_last_compare]        
      
      user_code             = det_arr[1].to_s          

      if user_code == user_code_compare
        @struct_info = (FeedbacksStructure.find_by title: user.contact.struct).body
        #@struct_info = 'Nice '
        @level_info  = (FeedbacksLevel.find_by     title: user.contact.level).body        
        #@level_info  = '& Cool'
      end        
      
    end                
  end
  
end
