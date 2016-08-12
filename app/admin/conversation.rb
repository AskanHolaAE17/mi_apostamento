ActiveAdmin.register Conversation do
  controller do
    def permitted_params
      params.permit conversation: [:members]      
    end
  end
end



      


