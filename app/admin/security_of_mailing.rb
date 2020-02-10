ActiveAdmin.register SecurityOfMailing do
  controller do
    def permitted_params
      params.permit security_of_mailing: [:error_type, :error_request, :error_message, :counter, :when_starts_new_counter]      
    end
  end
end



      


