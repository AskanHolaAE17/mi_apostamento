class RequestsIncomingsController < ApplicationController

  def create
  end

  private  
    def requests_incoming_params
      params.require(:requests_incoming).permit(:user_id, :from, :status, :able)
    end  

    
end
