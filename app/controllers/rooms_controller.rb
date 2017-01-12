class RoomsController < ApplicationController



before_action :set_main_page,            only: [:show]
before_action :set_root,      :set_info, only: [:any_room]

#_______________________________________________________________________________



  def show    
  
    @root_path   = MeConstant.find_by_title('root_path').content      
  
    details      = params[:details]
    
    room_details = Base64.decode64(details)        
    #room_details_full = Base64.decode64(details)        
    
    #room_details      = room_details_full.partition('__').first
    #room_details_any  = room_details_full.partition('__').last
    
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


      # FEEDBACKS OPEN
      # getted Show Feedback Requests
      @getted_rqs_fb_show = ShowFeedbackRequest.where(receiver: @user.id)
      @getted_rqs_fb_show_from_users = []
      
      @getted_rqs_fb_show.each do |rq|
        @getted_rqs_fb_show_from_users << User.find(rq.user_id)
      end
      
        
        
      # sent Show Feedback Requests
      @sent_rqs_fb_show   = @user.show_feedback_requests
      @sent_rqs_fb_show_to_users = []
      
      @sent_rqs_fb_show.each do |rq|
        @sent_rqs_fb_show_to_users << User.find(rq.receiver)
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
      end   # # MESSAGES end                 
      
#_______________________________________
      
      
#_______________________________________


      # SHOW Feedbacks Users      
      
      #@show_feedbacks_rqs    = ShowFeedbackRequest.where("user_id LIKE ? OR receiver LIKE ?", "%#{@user.id}%", "%#{@user.id}%")
      @show_feedbacks_rqs    = ShowFeedbackRequest.where(["user_id = ? or receiver = ?", @user.id.to_s, @user.id.to_s])
      @show_feedbacks_rqs    = @show_feedbacks_rqs.where status: 'yes'
        @show_feedbacks_users_names = []
        @show_feedbacks_users_links = []
      
              
      @show_feedbacks_rqs.each do |c|
        #users_companions = c.members.split(' ')      
      
        #users_companions.each do |us_id|        
          #if us_id.to_s != @user.id.to_s
            #conversation_user = User.find(us_id)
            #@show_feedbacks_users_names << conversation_user.name.to_s + ' ' + conversation_user.surname.to_s
        user = if c.receiver.to_i != @user.id
          User.find(c.receiver)
        else
          User.find(c.user_id)
        end
        
            
        @show_feedbacks_users_names << user.name.to_s + ' ' + user.surname.to_s    
            
#______________________________________        

    
    # conv_link
    
      #conversation_id       = user.id
      #conv_user_first_id    = @user.id
      #conv_user_last_id     = user.id
      
      #conv_id_len           = conversation_id.to_s.length
      #conv_user_last_id_len = conv_user_last_id.to_s.length

           
      #conv_details          = conv_id_len.to_s                 +
      #                        conversation_id.to_s             +
      #                        conv_user_first_id.to_s          +
      #                        conv_user_last_id.to_s           +
      #                        conv_user_last_id_len.to_s       +
      #                        @user.id.to_s                    +                             
      #                        @user.id.to_s.length.to_s


      #conv_details_64       = (Base64.encode64 conv_details).chomp.delete("\n").delete('=')
      #conv_details          = conv_details_64

#______________________________________        


    fbo_user_id_in_base       = user.id_in_base.to_s   # FeedBacks Open - fbo
    fbo_user_iib_last         = fbo_user_id_in_base.length - 1
    fbo_user_code             = fbo_user_id_in_base[fbo_user_iib_last - 1] + fbo_user_id_in_base[fbo_user_iib_last]
    
    fbo_feed_al_arr           = fbo_feedback_sl_array = []    
    fbo_feed_al_arr << user.id
    fbo_feed_al_arr << ('a'..'z').to_a.shuffle.first
    fbo_feed_al_arr << fbo_user_code

    fbo_details               = full_encode_array_to_link_details(fbo_feed_al_arr, false)
    
    fbo_details               = Base64.decode64 fbo_details
    
    
    
    fbo_user_id               = @user.id.to_s   
    fbo_contact_id            = @user.contact.id.to_s
    
    fbo_user_id_in_base_first = @user.id_in_base.to_s.first.to_i.to_s      


    fbo_contact_id_letter     = fbo_contact_id.insert(fbo_contact_id.length-1, (0..9).to_a.shuffle.first.to_s)
    
    fbo_contact_i_am_details  = fbo_contact_id_letter.insert(fbo_contact_id_letter.length-1, fbo_user_id_in_base_first)                                
    
#______________________________________
            

            show_feedbacks_users_links_details    = fbo_details + '__' + fbo_contact_i_am_details
            
            show_feedbacks_users_links_details_64 = (Base64.encode64 show_feedbacks_users_links_details).delete("\n").delete('=')
            

            @show_feedbacks_users_links << show_feedbacks_users_links_details_64
          #end
        #end
        
      end   # @show_feedbacks_users.each do |c|                 
      
#_______________________________________

      
    end    
    
#___________________________________________________________

    
    # NAVIGATION MENU - ROOM
    navigation_menu_room(@user, 'ro')    
    
    
  end   # DEF

#_______________________________________________________________________________
    

  def any_room     # ROOM_SEE root
  
    @root_path     = MeConstant.find_by_title('root_path').content      
  
    details_64     = params[:details]
    details_full   = Base64.decode64(details_64)        
        
    
    room_details      = details_full.partition('__').first        
    
    contact_i_am_info = details_full.partition('__').last    
    
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


    room_id = ''  # getting of user_id  
    
    for i in 0..room_details.length-1
      unless room_details[i].in? ('a'..'z')
        room_id += room_details[i]
        @current_i += 1
      else        
        break
      end
    end   
    
    room_id = room_id.to_i
    
    
    #skip alphabet symbols         
    for i in @current_i..room_details.length-1
      if room_details[i].in? ('a'..'z')
        @current_i += 1
      else
        break  
      end
    end     
    
#_______________________________________

    
    user_id = ''  # getting of room_id
    
    for i in @current_i..room_details.length-1
      unless room_details[i] == '_'
        user_id += room_details[i]        
      else        
        @current_i += 1
        break
      end  
      @current_i += 1      
    end        
    
    @current_i += 1 if room_details[@current_i] == '_'
    
    user_id      = user_id.to_i    
    @user_id_any = user_id
    
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
  
  
    @user    = User.find(user_id)  # request Receiver
    @room    = Room.find(room_id)
    @contact = @user.contact    
    
    user_id  = user_id.to_s
    room_id  = room_id.to_s    
        
#_______________________________________

    
    unless @user                                                   and 
           @room                                                   and 
           @room.user_id.to_s == user_id                           and 
           user_id_in_base_start_2symbols == @user.id_in_base[0,2] and 
           room_id_in_base_start_3symbols == @room.id_in_base[0,3] and 
           contact_i_am_info                                          and
           contact_i_am_info != ''
    
      redirect_to root_path + 'info/' + 'dannue_receive_obrabotanu'      
      
#_______________________________________

      
    else            
      
      #contact_i_am_info
      
      iam_details           = contact_i_am_info.to_s
      iam_contact_full_id   = iam_details.clone
      
      user_id_in_base_first_get         = iam_details[iam_details.length-2]
      iam_details[iam_details.length-2] = ''
      
      iam_details[iam_details.length-2] = ''      
      
      contact_id            = iam_details
      contact               = Contact.find(contact_id)      
      
#_______________________________________

      
      if contact and @user_me = User.find(contact.user_id) and @user_me
      
        user_id_in_base_first_is = @user_me.id_in_base.to_s.first.to_i.to_s        
        
      #_______________________________________
        
                
        if user_id_in_base_first_is == user_id_in_base_first_get                  

#_______________________________________


          # ROOM SEE PAGE - LOADED SUCCESS
      
          @requests_of_current_user = @user_me.requests_for_communications
      
          navigation_menu_room(@user_me, 'roo')
          
          #@contact = (User.find(@user_id_any)).contact
          
#_______________________________________


      # SHOW Feedbacks Button
      
      #@feedback_open_request        = ShowFeedbackRequest.find_by user_id: @user_me.id
      @feedback_open_rqs            = ShowFeedbackRequest.where("user_id LIKE ? OR receiver LIKE ?", "%#{@user_me.id}%", "%#{@user_me.id}%")
      
      @feedback_open_rqs.each do |fb_open_rq|
        if fb_open_rq.user_id == @user.id or fb_open_rq.receiver == @user.id
          @feedback_open_request = fb_open_rq
          break
        end
      end
      
      @feedback_open_request_status = @feedback_open_request.status if @feedback_open_request          
          
#_______________________________________

    
    #MESSAGE    
    
    @sender_id         = @user_me.id.to_s
    @message           = @user_me.messages.build    
    @message_letter    = ('a'..'z').to_a.shuffle.first        
    
    user_id_in_base    = @user_me.id_in_base.to_s
    id_in_base_begin   = user_id_in_base[0,2]
    id_in_base_end     = user_id_in_base[2, user_id_in_base.length-1]
    
    message_details    = id_in_base_begin               +
                         '_'                            +
                         id_in_base_end                 +
                         ('a'..'z').to_a.shuffle.first  +
                         '_'                            
                         
    #message_details_64 = Base64.encode64 message_details                         
    @root_path = root_path                     
                                                                                                                                                                                                             
    @message_path_new  = message_details                 

#_______________________________________

        
        else   # if user_id_in_base_first_is == user_id_in_base_first_get
        
          redirect_to root_path + 'info/' + 'dannue_receive_obrabotanu'      
        
        end   # if user_id_in_base_first_is == user_id_in_base_first_get
      
      #_______________________________________
      
      
      else   # if contact and user = User.find(contact.user_id) and user
      
        redirect_to root_path + 'info/' + 'dannue_receive_obrabotanu'      
        
      end   # if contact and user = User.find(contact.user_id) and user
      
      
    end   # unless @user and @room and @room.user_id ... and iam_details ...    
  
#_______________________________________

  
  end  # DEF
  
#_______________________________________________________________________________    



  private
  
    def set_main_page
      @main_page  = MainPage.find(1)       
    end          

    def user_params
      params.require(:room).permit(:user_id, :id_in_base, :font_size, :tmp_income_key)
    end  
    
    
    
    def set_root
      root_path   = MeConstant.find_by_title('root_path').content    
      @root_path  = root_path
    end  
  
    def set_info
      @site_title = MeConstant.find_by_title('site_title').content
      @main_page  = MainPage.find(1)   
      
      @page       = Page.find_by_page :conversations
    end                

    
end
