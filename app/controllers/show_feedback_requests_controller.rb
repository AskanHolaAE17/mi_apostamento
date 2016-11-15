# encoding: utf-8 
class ShowFeedbackRequestsController < ApplicationController


before_action :set_root, :set_info, only: [:show]

#_______________________________________________________________________________  


  def create
  
    root_path = MeConstant.find_by_title('root_path').content  

#______________________________________

  
    user_sender    = User.find(params[:user_id]) 
    
    request        = show_feedback_request = user_sender.show_feedback_requests.build(show_feedback_request_params)   
    
    
    user_receiver  = User.find(request.receiver)        
    user           = user_receiver
    
    room           = user.room    

#______________________________________


    # ROOM

      plus_2_letters           = ('a'..'z').to_a.shuffle.first + 
                                 ('a'..'z').to_a.shuffle.first
                                 
      plus_3_letters           = ('a'..'z').to_a.shuffle.first + 
                                 ('a'..'z').to_a.shuffle.first + 
                                 ('a'..'z').to_a.shuffle.first                                       
           
      room_details             = user_receiver.id.to_s                  + 
                                 plus_2_letters                         + 
                                 room.id.to_s                           +
                                 '_'                                    +
                                 user_receiver.id_in_base.to_s[0, 2]    +
                                 plus_3_letters                         + 
                                 room.id_in_base.to_s[0, 3]                                                      


      devider_central_position = room_details.index('_')            
      devider_start_position   = devider_central_position.to_i / 2      
      
      time_now_min             = Time.now.min
      devider_end_position     = if time_now_min % 2 == 0
        room_details.length-3
      else  
        room_details.length-2 
      end  
      
      room_details.insert(devider_start_position, '_')
      room_details.insert(devider_end_position, '_')
      


      room_details_encoded_64  = (Base64.encode64 room_details).chomp.delete("\n")
      room_details             = room_details_encoded_64 



      room_url                 = root_path                      + 
                                'room/'                         + 
                                 room_details                                                
    
#______________________________________


    link_with_contacts = unless flash[:link_with_contacts]
    
      order = User.find(request.user_id).contact.order   # REQUEST is show_feedback_request
    
      contacts_status = if order.group == 'GOOD GROUP'                     
        [2,4,6,8].shuffle.first.to_s
      else
        [1,3,5,7,9].shuffle.first.to_s      
      end

      plus_2_letters      = ('a'..'z').to_a.shuffle.first + 
                            ('a'..'z').to_a.shuffle.first
           
      contacts_details    = contacts_status               + 
                            order.id.to_s                 + 
                            plus_2_letters                + 
                            order.akey_payed                     



      contacts_details  = (Base64.encode64 contacts_details).chomp.delete("\n")
      #contacts_details     = contacts_details_encoded_64 + '='



      link_with_contacts = root_path                      + 
                           'contacts/'                    + 
                           contacts_details                                                
                           
    else                           
      flash[:link_with_contacts]                            
    end  
    
    flash[:link_with_contacts] = link_with_contacts                           

#______________________________________        


    request_fb_show_exist = ShowFeedbackRequest.find_by user_id: user_sender.id   
    if request_fb_show_exist and request_fb_show_exist.receiver == request.receiver  # if request from current user was sended to this receiver
      msg = (RoomNonverballyInfoPage.find_by translit: 'zapros_na_otkrutie_obratnuh_svyazey_yzhe_bul_otpravlen').msg      
                        
    elsif request.save
    
      room_url = room_url + '#open_feedback'
      UserNonverballyActionsMailer.new_incoming_request_for_open_feedback(user_sender, user_receiver, room_url ).deliver      
      msg = (RoomNonverballyInfoPage.find_by translit: 'zapros_na_otkrutie_obratnuh_svyazey_otpravlen').msg
        
#______________________________________        

    else   # unless request.save          
    
      msg = (RoomNonverballyInfoPage.find_by translit: 'zapros_na_otkrutie_obratnuh_svyazey_ne_bul_otpravlen').msg      
    end   # end request.save      
      
      
      flash[:info_on_request_added] = msg                
      redirect_to link_with_contacts    
    
  end   # end def create
  
#_______________________________________________________________________________

  
  def update
  
    root_path = MeConstant.find_by_title('root_path').content  

#______________________________________

    receiver       = params[:requests_for_communication][:receiver]
    user_sender    = User.find(params[:user_id])
         
    requests       = ShowFeedbackRequest.where user_id: user_sender.id    
    request        = user_sender.show_feedback_requests.find_by receiver: receiver
    
    request.update_attributes(show_feedback_request_params)
    request.save

#______________________________________        


    room_url = unless flash[:room_url]
    
    # ROOM
    
      user_receiver            = User.find(receiver)
      room                     = user_receiver.room    
      

      plus_2_letters           = ('a'..'z').to_a.shuffle.first + 
                                 ('a'..'z').to_a.shuffle.first
                                 
      plus_3_letters           = ('a'..'z').to_a.shuffle.first + 
                                 ('a'..'z').to_a.shuffle.first + 
                                 ('a'..'z').to_a.shuffle.first                                       
           
      room_details             = user_receiver.id.to_s                  + 
                                 plus_2_letters                         + 
                                 room.id.to_s                           +
                                 '_'                                    +
                                 user_receiver.id_in_base.to_s[0, 2]    +
                                 plus_3_letters                         + 
                                 room.id_in_base.to_s[0, 3]                                                      


      devider_central_position = room_details.index('_')            
      devider_start_position   = devider_central_position.to_i / 2      
      
      time_now_min             = Time.now.min
      devider_end_position     = if time_now_min % 2 == 0
        room_details.length-3
      else  
        room_details.length-2 
      end  
      
      room_details.insert(devider_start_position, '_')
      room_details.insert(devider_end_position, '_')
      


      room_details_encoded_64  = (Base64.encode64 room_details).chomp.delete("\n")
      room_details             = room_details_encoded_64 



      room_url                 = root_path                      + 
                                'room/'                         + 
                                 room_details                                                
                           
    else                           
      flash[:room_url]                            
    end  
    
    flash[:room_url] = room_url

#______________________________________


    link_with_contacts = unless flash[:link_with_contacts]
    
      order = User.find(request.user_id).contact.order   
    
      contacts_status = if order.group == 'GOOD GROUP'                     
        [2,4,6,8].shuffle.first.to_s
      else
        [1,3,5,7,9].shuffle.first.to_s      
      end

      plus_2_letters      = ('a'..'z').to_a.shuffle.first + 
                            ('a'..'z').to_a.shuffle.first
           
      contacts_details    = contacts_status               + 
                            order.id.to_s                 + 
                            plus_2_letters                + 
                            order.akey_payed                     



      contacts_details_encoded_64  = (Base64.encode64 contacts_details).chomp.delete("\n")
      #contacts_details     = contacts_details_encoded_64 + '='



      link_with_contacts = root_path                      + 
                           'contacts/'                    + 
                           contacts_details               
    end                       
      
                           
      flash[:link_with_contacts] = link_with_contacts                                                             

#_______________________________________________________________________________

           
    user_sender.feedback_able_users_ids_list   = user_sender.feedback_able_users_ids_list.to_s + user_receiver.id.to_s  + ' '
    user_receiver.feedback_able_users_ids_list = user_receiver.feedback_able_users_ids_list.to_s + user_sender.id.to_s  + ' '       

#_______________________________________________________________________________

    
    #conversation = Conversation.new
    #conversation.members = user_sender.id.to_s + ' ' + user_receiver.id.to_s                 
      
#_______________________________________________________________________________

          
    if user_sender.save and user_receiver.save and request.save 
       #and conversation.save
      msg = (RoomNonverballyInfoPage.find_by translit: 'zapros_na_otkrutie_obratnuh_svyazey_odobren').msg                
      
      room_url = room_url + '#show_feedback'
      UserNonverballyActionsMailer.request_for_open_feedback_is_approved(user_receiver, user_sender, room_url).deliver
      
    else
      msg = (OrderInfoPage.find_by translit: 'poprobyyte_eshche_raz').msg                  
    end

#______________________________________            


    flash[:answer_on_request] = msg    

    redirect_to room_url
          
  end

#__________________________________________________________________________________________________________________________________________________

  
  def destroy
  
    root_path = MeConstant.find_by_title('root_path').content  

#______________________________________


    receiver       = params[:show_feedback_request][:receiver]
    user_sender    = User.find(params[:user_id])
         
    requests       = ShowFeedbackRequest.where user_id: user_sender.id    
    request        = user_sender.show_feedback_requests.find_by receiver: receiver
    
    request.update_attributes(show_feedback_request_params)    

#______________________________________        

    #RELOAD PAGE
    room_url_reload = unless flash[:room_url_reload]
    
    # ROOM
    
      user_receiver            = User.find(receiver)
      room                     = user_receiver.room    
      

      plus_2_letters           = ('a'..'z').to_a.shuffle.first + 
                                 ('a'..'z').to_a.shuffle.first
                                 
      plus_3_letters           = ('a'..'z').to_a.shuffle.first + 
                                 ('a'..'z').to_a.shuffle.first + 
                                 ('a'..'z').to_a.shuffle.first                                       
           
      room_details             = user_receiver.id.to_s                  + 
                                 plus_2_letters                         + 
                                 room.id.to_s                           +
                                 '_'                                    +
                                 user_receiver.id_in_base.to_s[0, 2]    +
                                 plus_3_letters                         + 
                                 room.id_in_base.to_s[0, 3]                                                      


      devider_central_position = room_details.index('_')            
      devider_start_position   = devider_central_position.to_i / 2      
      
      time_now_min             = Time.now.min
      devider_end_position     = if time_now_min % 2 == 0
        room_details.length-3
      else  
        room_details.length-2 
      end  
      
      room_details.insert(devider_start_position, '_')
      room_details.insert(devider_end_position, '_')
      


      room_details_encoded_64  = (Base64.encode64 room_details).chomp.delete("\n")
      room_details             = room_details_encoded_64 



      room_url                 = root_path                      + 
                                'room/'                         + 
                                 room_details                                                
                           
    else                           
      flash[:room_url_reload]                            
    end  
    
    flash[:room_url_reload] = room_url_reload

#______________________________________


    # EMAIL
    room_url = unless flash[:room_url]
    
    # ROOM
    
      user_receiver            = User.find(receiver)
      the_room                 = user_sender.room    
      

      plus_2_letters           = ('a'..'z').to_a.shuffle.first + 
                                 ('a'..'z').to_a.shuffle.first
                                 
      plus_3_letters           = ('a'..'z').to_a.shuffle.first + 
                                 ('a'..'z').to_a.shuffle.first + 
                                 ('a'..'z').to_a.shuffle.first                                       
           
      room_details             = user_sender.id.to_s                    + 
                                 plus_2_letters                         + 
                                 the_room.id.to_s                           +
                                 '_'                                    +
                                 user_sender.id_in_base.to_s[0, 2]      +
                                 plus_3_letters                         + 
                                 the_room.id_in_base.to_s[0, 3]                                                      


      devider_central_position = room_details.index('_')            
      devider_start_position   = devider_central_position.to_i / 2      
      
      time_now_min             = Time.now.min
      devider_end_position     = if time_now_min % 2 == 0
        room_details.length-3
      else  
        room_details.length-2 
      end  
      
      room_details.insert(devider_start_position, '_')
      room_details.insert(devider_end_position, '_')
      


      room_details_encoded_64  = (Base64.encode64 room_details).chomp.delete("\n")
      room_details             = room_details_encoded_64 



      room_url                 = root_path                      + 
                                'room/'                         + 
                                 room_details                                                
                           
    else                           
      flash[:room_url]                            
    end  
    
    flash[:room_url] = room_url

#______________________________________


    link_with_contacts = unless flash[:link_with_contacts]
    
      order = User.find(request.user_id).contact.order   
    
      contacts_status = if order.group == 'GOOD GROUP'                     
        [2,4,6,8].shuffle.first.to_s
      else
        [1,3,5,7,9].shuffle.first.to_s      
      end

      plus_2_letters      = ('a'..'z').to_a.shuffle.first + 
                            ('a'..'z').to_a.shuffle.first
           
      contacts_details    = contacts_status               + 
                            order.id.to_s                 + 
                            plus_2_letters                + 
                            order.akey_payed                     



      contacts_details  = (Base64.encode64 contacts_details).chomp.delete("\n")
      #contacts_details     = contacts_details_encoded_64 + '='



      link_with_contacts = root_path                      + 
                           'contacts/'                    + 
                           contacts_details               
                           
      
      end                     
      flash[:link_with_contacts] = link_with_contacts                                                             

#_______________________________________________________________________________


    if request.save
      msg = (RoomNonverballyInfoPage.find_by translit: 'zapros_na_otkrutie_obratnuh_svyazey_otklonen').msg                
      UserNonverballyActionsMailer.request_for_open_feedback_is_rejected(user_receiver, user_sender, room_url, link_with_contacts).deliver
      
    else
      msg = (OrderInfoPage.find_by translit: 'poprobyyte_eshche_raz').msg                  
    end

#______________________________________            


    flash[:answer_on_request] = msg    

    redirect_to room_url_reload
          
  end

#_______________________________________________________________________________


  def show  

    details_64  = params[:details]
    details     = Base64.decode64 details_64


    req_id_len  = details.last.to_i
    
    details     = details[0..details.length-2]


    req_user_id            = details[details.length-req_id_len..details.length-1].to_s
    
    req_user_code          = details[0...details.length-req_id_len]   # DONE=)           
        
#______________________________________


    user_id     = req_user_id
    user_code   = req_user_code
    
    user        = User.find(user_id)
    
#______________________________________


    user_id_in_b     = user.id_in_base.to_s if user
    user_id_in_b_len = user_id_in_b.length
      
    if user and user_id_in_b[user_id_in_b.length-req_id_len..user_id_in_b.length-1] == user_code


      # getted Requests
      @getted_rqs_fb_show = ShowFeedbackRequest.where(receiver: user.id)
      @getted_rqs_fb_show_from_users = []
      
      @getted_rqs_fb_show.each do |rq|
        @getted_rqs_fb_show_from_users << User.find(rq.user_id)
      end      
        
        
      # sent Requests  
      @sent_rqs_fb_show   = user.requests_for_communications
      @sent_rqs_fb_show_to_users = []
      
      @sent_rqs_fb_show.each do |rq|
        @sent_rqs_fb_show_to_users << User.find(rq.receiver)
      end      

#_______________________________________

      navigation_menu_room(user, 'fes')


    else   # unless user and user_id_in_b... == user_code

#_______________________________________

    
      redirect_to root_path + 'info/' + 'dannue_receive_obrabotanu'  
    end   # if order and order.akey[0..2] == order_akey           

    
  end  
  
#_______________________________________________________________________________  
  
  
  
  private  
  
    def set_root
      root_path   = MeConstant.find_by_title('root_path').content    
    end  
  
    def set_info
      @site_title = MeConstant.find_by_title('site_title').content
      @main_page  = MainPage.find(1)   
      
      @page       = Page.find_by_page :requests                
    end          
      
    def show_feedback_request_params
      params.require(:show_feedback_request).permit(:user_id, :receiver, :status, :able)
    end  
  

end
