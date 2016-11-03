ActiveAdmin.register Contact do
  controller do
    def permitted_params
      params.permit contact: [:name, :surname, :city, :country, :birthday, 
                              :email, :order_number, 
                              :able_for_contact, :group, :own_gender, 
                              :search_for_gender, :struct_test_info, 
                              :level, :level_test_info, 
                              :link_for_disable_contact,
                              :image, :image_file_name, :image_content_type, 
                              :image_file_size, :image_updated_at, 
                              :utf8,:_method, :authenticity_token, :commit, :id,
                              :user_id, :secret_question, 
                              :secret_answer_1, :secret_answer_2, :structure,
                              :about_info, :deep_info, :looking_for,
                              :ready_strong]                              
    end
  end
end



      


