ActiveAdmin.register ContactClone do
  controller do
    def permitted_params
      params.permit contact_clone: [:name, :surname, :city, :country, :birthday, 
                                    :about_info, :deep_info, 
                                    
                                    :own_gender, :search_for_gender, 
                                    :secret_question, 
                                    :secret_answer_1, :secret_answer_2, 
                                    
                                    :order_number, :email, :group, 
                                    :able_for_contact]                              
    end
  end
end
