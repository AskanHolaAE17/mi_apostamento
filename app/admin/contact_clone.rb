ActiveAdmin.register ContactClone do
  controller do
    def permitted_params
      params.permit contact_clone: [:name, :surname, :city, :country, :birthday,                                      
                                    
                                    :own_gender, :search_for_gender, 
                                    :secret_question, 
                                    :secret_answer_1, :secret_answer_2, 
                                    
                                    :order_number, :email, :group, 
                                    :able_for_contact, 
                                    :about_info, :deep_info, :looking_for]                              
    end
  end
end
