class RoomsController < ApplicationController

before_action :set_main_page, only: [:show]

#_______________________________________________________________________________


  def show
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
      @messages_from_you = Messages.find_by user_id:  @user.id
      
      @messages_from_you.each do |msg|
      end
      
      
      
      @messages_to_you   = Messages.find_by receiver: @user.id            
           
#_______________________________________
      
      
    end
    
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
