class RoomsController < ApplicationController

before_action :set_main_page, only: [:show]

#_______________________________________________________________________________


  def show    
  
    @root_path  = MeConstant.find_by_title('root_path').content      
  
    details = params[:details]
    
    room_details = Base64.decode64(details)        
    
#_______________________________________

    
    @room_details_res     = ''
    @devider_pos_counter  = 0
    
    room_details.split('').each do |a|  #remote all '_' but central
      if a == '_'
        @devider_pos_counter += 1
        
        unless @devider_pos_counter == 2
          next
        end
        
      end  
      
      @room_details_res  += a
    end 
      
    room_details          = @room_details_res.to_s 
    
#_______________________________________    


    @current_i = 0  # common counter of position

#_______________________________________    


    user_id = ''  # getting of user_id  
    
    for i in 0..room_details.length-1
      unless room_details[i].in? ('a'..'z')
        user_id += room_details[i]
        @current_i += 1
      else        
        break
      end
    end   
    
    user_id = user_id.to_i
    
    
    #skip alphabet symbols         
    for i in @current_i..room_details.length-1
      if room_details[i].in? ('a'..'z')
        @current_i += 1
      else
        break  
      end
    end     
    
#_______________________________________

    
    room_id = ''  # getting of room_id
    
    for i in @current_i..room_details.length-1
      unless room_details[i] == '_'
        room_id += room_details[i]        
      else        
        @current_i += 1
        break
      end  
      @current_i += 1      
    end        
    
    @current_i += 1 if room_details[@current_i] == '_'
    
    room_id = room_id.to_i    
    
#_______________________________________

    
    user_id_in_base_start_2symbols = ''   # getting of user_id_in_base (start_2symbols)
    
    for i in @current_i..room_details.length-1
      unless room_details[i].in? ('a'..'z') 
        user_id_in_base_start_2symbols += room_details[i]
        @current_i += 1        
      else
        break
      end  
    end     
    
    
    #skip alphabet symbols         
    for i in @current_i..room_details.length-1
      if room_details[i].in? ('a'..'z')
        @current_i += 1
      else
        break  
      end
    end         
    
#_______________________________________

    
    room_id_in_base_start_3symbols = ''   # getting of room_id_in_base (start_3symbols)
    
    for i in @current_i..room_details.length-1
      unless room_details[i].in? ('a'..'z') 
        room_id_in_base_start_3symbols += room_details[i]
      else
        break
      end  
    end     
    
#_______________________________________  
  
  
    @user = User.find(user_id)  # request Receiver
    @room = Room.find(room_id)
    
    user_id = user_id.to_s
    room_id = room_id.to_s    
        
#_______________________________________

    
    unless @user and @room and @room.user_id.to_s == user_id and user_id_in_base_start_2symbols == @user.id_in_base[0,2] and room_id_in_base_start_3symbols == @room.id_in_base[0,3]
      redirect_to ''
    else        
      @page       = Page.find_by_page :room_one        
      
#_______________________________________      


      # REQUESTS      
      # getted Requests
      @getted_rqs = RequestsForCommunication.where(receiver: @user.id)
      @getted_rqs_from_users = []
      
      @getted_rqs.each do |rq|
        @getted_rqs_from_users << User.find(rq.user_id)
      end
      
        
        
      # sent Requests  
      @sent_rqs   = @user.requests_for_communications
      @sent_rqs_to_users = []
      
      @sent_rqs.each do |rq|
        @sent_rqs_to_users << User.find(rq.receiver)
      end      

#_______________________________________


      # MESSAGES
      
      #messages_from_you = Message.where user_id:  @user.id
      
      #if messages_from_you
      #  messages_from_you.each do |msg|
      #    msg.msg_type = 'outcoming'
      #  end
      #end  
      
      
      
      #messages_to_you   = Message.where receiver: @user.id            
      #if messages_to_you 
      #  messages_to_you.each do |msg|
      #    msg.msg_type = 'incoming'
      #  end
      #end      
      
      
      ##messages = messages_to_you.merge(messages_from_you)            
      #@messages = messages.order(created_at: :desc)
      
      @conversations    = Conversation.where("members LIKE ?" , "%#{@user.id}%")
        @conversations_msg_users_names = []
        @conversations_msg_users_links = []
              
      @conversations.each do |c|
        users_companions = c.members.split(' ')      
      
        users_companions.each do |us_id|        
          if us_id.to_s != @user.id.to_s
            conversation_user = User.find(us_id)
            @conversations_msg_users_names << conversation_user.name.to_s + ' ' + conversation_user.surname.to_s
#______________________________________        

    
    # conv_link
    
      conversation_id       = c.id
      conv_user_first_id    = users_companions.first
      conv_user_last_id     = users_companions.last
      
      conv_id_len           = conversation_id.to_s.length
      conv_user_last_id_len = conv_user_last_id.length

           
      conv_details          = conv_id_len.to_s                 +
                              conversation_id.to_s             +
                              conv_user_first_id.to_s          +
                              conv_user_last_id.to_s           +
                              conv_user_last_id_len.to_s       +
                              @user.id.to_s                    +                             
                              @user.id.to_s.length.to_s


      conv_details_64       = (Base64.encode64 conv_details).chomp.delete("\n")
      conv_details          = conv_details_64

#______________________________________
            
            @conversations_msg_users_links << conv_details
          end
        end
      end           
           
#_______________________________________
      
      
    end
    
#___________________________________________________________


    # RECOMMENDATIONS +in NAVIGATION MENU - ROOM
   
    user_id_in_base       = @user.id_in_base.to_s
    user_iib_last         = user_id_in_base.length - 1
    user_code             = user_id_in_base[user_iib_last - 1] + user_id_in_base[user_iib_last]
    
    feed_al_arr           =  feedback_sl_array = []    
    feed_al_arr << @user.id
    feed_al_arr << ('a'..'z').to_a.shuffle.first
    feed_al_arr << user_code

    details               = full_encode_array_to_link_details(feed_al_arr, false)
    @link_to_feedbacks_sl = root_path + 'recommendations/' + details   #  Structure Level
    
    
    @recommendations_menu_title = 'Для Вас и Вашего партнера'

#___________________________________________________________


    # NAVIGATION MENU - ROOM
    
    user = @user

#______________________________________

     
    # NAVIGATION MENU - ROOM
    # REQUESTS
    
    req_link_id      = user.id.to_s
    
    req_code         = user.id_in_base.to_s   # requests_link_id_in_base
    req_code_len     = req_code.length
    req_link_code    = req_code[req_code_len-3..req_code_len-1]    
    
    req_link_id_len  = req_link_id.length.to_s    
    
    
    requests_link_details        = req_link_code + req_link_id + req_link_id_len
    requests_link_details_64     = (Base64.encode64 requests_link_details).delete("\n").delete('=')
    
    @nav_menu_room_requests_link = root_path + 'requests/' + requests_link_details_64
    @requests_menu_title         = 'Запросы на общение - полученные и отправленные'
    
#______________________________________


    # NAVIGATION MENU - ROOM
    # CONVERSATIONS    
    
    conv_link_id      = user.id.to_s
    
    conv_code         = user.id_in_base.to_s   # requests_link_id_in_base
    conv_code_len     = conv_code.length
    conv_link_code    = conv_code[conv_code_len-3..conv_code_len-1]    
    
    conv_link_id_len  = conv_link_id.length.to_s    
    
    
    convs_link_details          = conv_link_code + conv_link_id + conv_link_id_len
    convs_link_details_64       = (Base64.encode64 convs_link_details).delete("\n").delete('=')
    
    @nav_menu_room_convers_link = root_path + 'conversations/' + convs_link_details_64
    @convers_menu_title         = 'по переписке'

#______________________________________


    # NAVIGATION MENU - ROOM
    # SHOW/OFF IN BASE 
    
    user_off_db_id_len         = user.id.to_s.length.to_s
      
    user_off_db_id_in_base_len = user.id_in_base.length
    user_off_db_code           = user.id_in_base[user_off_db_id_in_base_len-4..user_off_db_id_in_base_len-2]
      
      
    show_off_db_details_64     = user.id.to_s + user_off_db_code + user_off_db_id_len
    show_off_db_details        = (Base64.encode64 show_off_db_details_64).delete("\n").delete('=')
          
#______________________________________

    
    if user.contact.able_for_contact
    
      # OFF
      # off show                  
    
      off_db_link_now         = root_path    + 'in_from_base/' + 'f' + show_off_db_details
      
      @show_off_in_base_menu_name  = 'Удалиться'
      @show_off_in_base_menu_title = 'из базы (другие пользователи не будут Вас видеть)'

#__________________________________________    

    
    else


      # SHOW
      #      
      
      # just if ALREADY in DB
      if user.contact.order.more_info_save      
    
        show_db_link = root_path + 'in_from_base/' + 'i' + show_off_db_details        
        
        @show_off_in_base_menu_name = 'Добавиться'
        @show_off_in_base_menu_title = 'в базу (другие пользователи смогут Вас видеть)'
            
#__________________________________________    

      
      else   # unless user.contact.order.more_form_save

        order_db = user.contact.order
        
        # open MORE INFO FORM
        show_db_form_redirect_letter  = ('a'..'z').to_a.shuffle.first
        show_db_form_link_details     = order_db.id.to_s               + 
                                        show_db_form_redirect_letter   + 
                                        order_db.akey_payed

#____________________


        show_db_form_link_details_encoded_64  = (Base64.encode64 show_db_form_link_details).chomp.delete("\n")  
    
#____________________

      
        off_db_link_form         = root_path + 'much_form/' + show_db_form_link_details_encoded_64          
        
      end   # if user.contact.order.more_form_save
              
          
    end
    

    @nav_menu_room_show_off_in_base_link = if off_db_link_form
    
      off_db_link_form      
    else  
    
      (show_db_link || off_db_link_now) + '__' + 'ro' + '_' + params[:details]   
    end
      
    
    # ro - Room

#______________________________________


    # NAVIGATION MENU - ROOM
    # CONTACTS
    
    # just if user SHOW in DB        


#______________________________________


    # NAVIGATION MENU - ROOM
    # CONSULTS
        

#______________________________________    
    
    
  end
  
#_______________________________________________________________________________




  private
  
    def set_main_page
      @main_page  = MainPage.find(1)       
    end          

    def user_params
      params.require(:room).permit(:user_id, :id_in_base, :font_size, :tmp_income_key)
    end  

    
end
