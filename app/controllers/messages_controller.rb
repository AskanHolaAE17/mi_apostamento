class MessagesController < ApplicationController


#_______________________________________________________________________________  


  def new
    
    @page       = Page.find_by_page :message_new
    @main_page  = MainPage.find(1)       
    
    @site_title = MeConstant.find_by_title('site_title').content 
  
#______________________________________
  
  
    details_64      = params[:details]
    details         = Base64.decode64 details_64
    
    details_arr     = details_from_url_to_array(details)
    
    user_id_in_base = details_arr[0].to_s
    sender_id       = details_arr[1].to_s
    
    

    @user           = User.find(sender_id)
    #@message        = @user.messages.build
    
#_____________________________________

    
      current_tmp_new_message_link_origin = ''
      details.each_char.with_index do |ch, i|
        unless ch == '_'
          current_tmp_new_message_link_origin += ch
        else
        
          @url_next = i + 1
          break
        end
      end      
      
      @url_next = details[@url_next.. -1]


    @current_tmp_new_message_link = current_tmp_new_message_link_origin    
    
#_____________________________________
    
    
    if @user and @user.id_in_base == user_id_in_base
      @sender_id     = sender_id
      @receiver_id   = details_arr[2].to_s      
      
      @receiver_name = User.find(@receiver_id).name
    else
      redirect_to   ''  
    end


    #if Contact.find_by(order_number: order_id)
    #  @exist_contact = Contact.find_by(order_number: order_id)
    #else  
    #  @exist_contact = Contact.new  
    #end      


    flash[:cur] = @user.id
  end

#_______________________________________________________________________________  

  



  def create
    root_path = MeConstant.find_by_title('root_path').content  

#______________________________________

  
    user_sender    = User.find(params[:user_id])        
    user_receiver  = User.find(params[:message][:receiver])     


    members1 = user_sender.id.to_s  + ' ' + user_receiver.id.to_s
    members2 = user_receiver.id.to_s + ' ' + user_sender.id.to_s
    
    conversation = Conversation.find_by members: members1
    if conversation == nil
      conversation = Conversation.find_by members: members2
    end
    if conversation == nil
      conversation = Conversation.new
      conversation.members = user_sender.id.to_s + ' ' + user_receiver.id.to_s                 
    end
        
    
    message              = conversation.messages.build(message_params)           

#______________________________________


      current_tmp_new_message_link_origin = ''
      message.current_tmp_new_message_link.each_char.with_index do |ch, i|
        unless ch == '_'
          current_tmp_new_message_link_origin += ch
        else
        
          @url_next = i + 1
          break
        end
      end      
      
      @url_next = message.current_tmp_new_message_link[@url_next.. -1]
      message.current_tmp_new_message_link = current_tmp_new_message_link_origin      

#______________________________________


    if message.save and conversation.save   #SAVE
    
#______________________________________


    room_url = unless flash[:room_url]
    
    # ROOM
    
      #user_receiver            = User.find(receiver)
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


      MessageMailer.new_income_message(user_sender, user_receiver, room_url).deliver    
      
      msg = (RoomVerballyInfoPage.find_by translit: 'soobshchenie_otpravleno').msg          
    else

#_______________________________________________________________________________  

    
      flash[:contact_title]            = message.title
      flash[:contact_body]             = message.body
      
#_______________________________________________________________________________      
      
              
      anchor = ''
      message.errors.each do |attr, msg|
        flash[:error_class_title]              = 'error_field' if attr == :title
        flash[:error_class_body]               = 'error_field' if attr == :body               

 
                
        flash[:autofocus_title]      = false                
        flash[:autofocus_body]       = false                
                          
#_______________________________________________________________________________        
                        
                        
      unless @skip_autofocus                  
        if attr == :title
          flash[:autofocus_title] = true
          @skip_autofocus = true
        else
            if attr == :body
              flash[:autofocus_body] = true
              @skip_autofocus = true
            end            
        end                
      end          #skip autofocus
        
#_______________________________________________________________________________


      unless @skip_anchor
        if attr == :title
          anchor = '1'
          @skip_anchor = true
        else  
        
            if attr == :body
              anchor = '2'
              @skip_anchor = true
            end                                      
        end                                          
        end    #skip_anchor
      end           #message.errors.each      
      
#_______________________________________________________________________________        
    
    
      msg = (OrderInfoPage.find_by translit: 'poprobyyte_eshche_raz').msg
      
            
      
      if @url_next == 'contacts'
        link_with_contacts = root_path + 'message_new/' + message.current_tmp_new_message_link
      end  

      if @url_next == 'msgs'
        link_with_contacts = root_path + 'messages/' + message.current_tmp_new_message_link
      end  
      
#_______________________________________________________________________________        

                    
    end  # end trying to save message
    
#_______________________________________________________________________________        

    
      if @url_next == 'contacts'
      


    link_with_contacts = unless flash[:link_with_contacts]
    
      order = User.find(message.user_id).contact.order   
    
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
      
      
      end  # if @url_next == 'contacts'

      if @url_next == 'msgs'
        link_with_contacts = root_path + 'messages/' + message.current_tmp_new_message_link
      end  # if @url_next == 'msgs'      
    
#_______________________________________________________________________________        

    
    message.current_tmp_new_message_link = ''
    message.save
    
    flash[:info_on_request_added] = msg                
    redirect_to link_with_contacts        
      
  end
   
#__________________________________________________________________________________________________________________________________________________


  def show
  
    @page       = Page.find_by_page :messages
    @main_page  = MainPage.find(1)       
    
    @site_title = MeConstant.find_by_title('site_title').content 
  
#______________________________________
  
  
    details_64              = params[:details]
    det                     = Base64.decode64(details_64)


    user_id_len = det[det.length - 1].to_i
    det_user_id_devide_symb = det.length - 1 - user_id_len.to_i
    @user_id                = det[det_user_id_devide_symb, user_id_len]
    det                     = det[0, det_user_id_devide_symb]    


    conv_id_len             = det[0].to_i
    conv_user_last_id_len   = det[det.length - 1].to_i
    
    conversation_id         = det[1, conv_id_len] 
    conv_user_last_id       = det[det.length - conv_user_last_id_len.to_i - 1, conv_user_last_id_len]
    conv_user_first_id      = det[1 + conversation_id.length, det.length - 1 - conversation_id.length - conv_user_last_id.length - conv_user_last_id_len.to_s.length]

#_______________________________________


    @sender_id = @user_id
    @receiver_id = conv_user_first_id if conv_user_first_id.to_s != @user_id.to_s
    @receiver_id = conv_user_last_id  if conv_user_last_id.to_s  != @user_id.to_s
    
    @current_tmp_new_message_link = details_64 + '_msgs'

#_______________________________________


    @user = User.find(@user_id)

    conv  = Conversation.find(conversation_id)    
    
    if conv    
      conv_members_arr = conv.members.split(' ')
      
      if (conv_members_arr[0] == conv_user_first_id) or (conv_members_arr[0] == conv_user_first_id) and (conv_members_arr[1] == conv_user_last_id) or (conv_members_arr[1] == conv_user_last_id)
        @messages = conv.messages      
      end
    end
    
#_______________________________________

   
      @users_msg_senders = []
      @messages = @messages.reverse
      @messages.each_with_index do |msg, i|
          #@msg_user_id_tmp = msg.user_id
          #@cur_user_id_tmp = @user_id      
        if msg.user_id.to_s == @user_id.to_s
          @users_msg_senders << 'Вы'
        else
          user_cur = User.find(msg.user_id)
          @users_msg_senders << ( user_cur.name.to_s + ' ' + user_cur.surname.to_s )
        end
      end      
                   

  end

#__________________________________________________________________________________________________________________________________________________

    

  private  
    def message_params
      params.require(:message).permit(:user_id, :msg_type, :receiver, :title, :body, :spam, :important, :deleted, :able, :current_tmp_new_message_link)
    end  

    
end
