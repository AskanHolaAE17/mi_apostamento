# encoding: utf-8
class FeedbacksStructuresLevelsController < ApplicationController



  def show

    @struct_info = 'Запрос выполняется'
    @level_info  = ''
    
  
    details      = params[:details]
    det_arr      = details_from_url_to_array(details, false)
    
    user_id      = det_arr[0]
    user         = User.find(user_id)        
        
    
    if user      
      user_id_in_base       = user.id_in_base.to_s
      user_iib_last_compare = user_id_in_base.length - 1
      user_code_compare     = user_id_in_base[user_iib_last - 1] + user_id_in_base[user_iib_last]        
      
      user_code             = det_arr[2].to_s          

      if user_code == user_code_compare
        #@struct_info = FeedbacksStructure.find_by title: user.contact.structure
        @struct_info = 'Nice '
        #@level_info  = FeedbacksLevel.find_by     title: user.contact.level        
        @level_info  = '& Cool'
      end        
      
    end                
  end
  
end
