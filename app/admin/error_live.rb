ActiveAdmin.register ErrorLive do
  controller do
    def permitted_params
      params.permit erro_live: [:error_title, :error_description, :notes, :error_number, :error_code]      
    end
  end
end



      


