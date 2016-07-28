class MessagesController < ApplicationController

  def create
  end

  private  
    def message_params
      params.require(:message).permit(:user_id, :msg_type, :sender, :title, :body, :spam, :important, :deleted, :able)
    end  

    
end
