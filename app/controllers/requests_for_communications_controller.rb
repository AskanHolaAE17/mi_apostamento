# encoding: utf-8 
class RequestsForCommunicationsController < ApplicationController


#_______________________________________________________________________________  


  def create
  
    root_path = MeConstant.find_by_title('root_path').content  

#______________________________________

  
    #request = requests_for_communication = RequestsForCommunication.new(requests_for_communication_params)
    user_sender = User.find(params[:user_id]) 
    request = requests_for_communication = user_sender.requests_for_communications.create(requests_for_communication_params)
    user_receiver = User.find(request.receiver)
    
    room_url = root_path + 'room'
    
#______________________________________


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
      contacts_details     = contacts_details_encoded_64 + '='



      link_with_contacts = root_path                      + 
                           'contacts/'                    + 
                           contacts_details                                                

#______________________________________        

              
    if request.save
    
      UserNonverballyActionsMailer.new_incoming_request_for_open_communication(user_sender, user_receiver, room_url).deliver      
      msg = (RoomNonverballyInfoPage.find_by translit: 'zapros_na_obshchenie_otpravlen').msg
        
#______________________________________        

    else   # unless request.save          
    
      msg = (RoomNonverballyInfoPage.find_by translit: 'zapros_na_obshchenie_ne_bul_otpravlen').msg      
    end   # end request.save      
      
      
      flash[:info_on_request_added] = msg                
      redirect_to link_with_contacts    
    
  end   # end def create
#_______________________________________________________________________________  
  
  
  
  private  
    def requests_for_communication_params
      params.require(:requests_for_communication).permit(:user_id, :receiver, :status, :able)
    end  
  

end