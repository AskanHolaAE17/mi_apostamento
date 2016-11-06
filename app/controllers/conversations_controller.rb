# encoding: utf-8
class ConversationsController < ApplicationController




before_action :set_root, :set_info, only: [:show]

#_______________________________________________________________________________    

  def create   
  end

#_____________________________________________________________________________________________________________________________________________

  def show
  
  
    details_64  = params[:details]
    details     = Base64.decode64 details_64


    id_len  = details.last.to_i
    
    details     = details[0..details.length-2]

#______________________________________        


    user_id            = details[details.length-id_len..details.length-1].to_s    
    user_code          = details[0...details.length-id_len]   # DONE=)           
                
    user        = User.find(user_id)
    
#______________________________________


    user_id_in_b     = user.id_in_base.to_s if user
    user_id_in_b_len = user_id_in_b.length
      
    if user and user_id_in_b[user_id_in_b.length-id_len..user_id_in_b.length-1] == user_code


      @conversations    = Conversation.where("members LIKE ?" , "%#{user.id}%")
        @conversations_msg_users_names = []
        @conversations_msg_users_links = []

#______________________________________        

              
      @conversations.each do |c|
        users_companions = c.members.split(' ')      

#______________________________________        

      
        users_companions.each do |us_id|        
        
          if us_id.to_s != user.id.to_s
        
          
            conversation_user = User.find(us_id)
            @conversations_msg_users_names << conversation_user.name.to_s + ' ' + conversation_user.surname.to_s

#______________________________________        

    
            # conv_link (one by one)
    
            conversation_id       = c.id
            conv_user_first_id    = users_companions.first
            conv_user_last_id     = users_companions.last
      
            conv_id_len           = conversation_id.to_s.length
            conv_user_last_id_len = conv_user_last_id.length

#______________________________________        

           
            conv_details          = conv_id_len.to_s                 +
                                    conversation_id.to_s             +
                                    conv_user_first_id.to_s          +
                                    conv_user_last_id.to_s           +
                                    conv_user_last_id_len.to_s       +
                                    user.id.to_s                     +                             
                                    user.id.to_s.length.to_s

#______________________________________        


            conv_details_64       = (Base64.encode64 conv_details).chomp.delete("\n")
            conv_details          = conv_details_64

            
            @conversations_msg_users_links << conv_details

            
          end   # if us_id.to_s != user.id.to_s
        end   # users_companions.each
      end   # @conversations.each           
           
#_______________________________________



    else   # unless user and user_id_in_b.. == user_code

#_______________________________________

    
      redirect_to root_path + 'info/' + 'dannue_receive_obrabotanu'  
    end   # if user and user_id_in_b.. == user_code

  end  
   
#_____________________________________________________________________________________________________________________________________________


    
  private
  
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
