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
        #@level_info  = (FeedbacksLevel.find_by     title: user.contact.level).body        
        
        @whose_partner   = user.contact.name
        @struct_recomend = (FeedbacksStructure.find_by title: user.contact.struct).recomend_part
        
        
        @square_class = 'square_green'        if user.contact.group == 'GOOD GROUP'    
        @square_class = 'square_violet'       if user.contact.group == 'BAD GROUP'
    
        #@title_on_hover = 'С этим человеком отношения безопасны'           if contact.group == 'GOOD GROUP'    
        #@title_on_hover = 'Построение отношений с этим человеком требует больше усилий'      if contact.group == 'BAD GROUP'                  
        
        
#_______________________________________


        navigation_menu_room(user, 're')            
        
      else   # unless order and order.akey == order_akey    

#_______________________________________

    
        redirect_to root_path + 'info/' + 'dannue_receive_obrabotanu'  
      
      end   # if user_code == user_code_compare
      
    else   # unless user

#_______________________________________

    
      redirect_to root_path + 'info/' + 'dannue_receive_obrabotanu'  
      
    end   # if user    
    
    
  end   # def
  
#_______________________________________________________________________________  
  
  
end
