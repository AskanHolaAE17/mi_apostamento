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
    
              
    unless request.save
      UserNonverballyActionsMailer.new_incoming_request_for_open_communication(user_sender, user_receiver, room_url).deliver
      redirect_to 'room_info_messages/zapros_na_obshchenie_otpravlen'
    else
    
      if flash[:contact_details_reload]
        redirect_to root_path + 'contacts/' + flash[:contact_details_reload] 
      else
        msg = (RoomNonverballyInfoPage.find_by translit: 'zapros_na_obshchenie_ne_bul_otpravlen').msg
        flash[:error_on_request_added] = msg
        redirect_to '/'
      end  
      
    end    
    
    
  end
#_______________________________________________________________________________  
  
  
  
  private  
    def requests_for_communication_params
      params.require(:requests_for_communication).permit(:user_id, :receiver, :status, :able)
    end  
  

end
