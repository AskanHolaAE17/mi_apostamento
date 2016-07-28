class RequestsOutcomingsController < ApplicationController

  def create
  end

  private  
    def requests_outcoming_params
      params.require(:requests_outcoming).permit(:user_id, :to, :status, :able)
    end  

    
end
