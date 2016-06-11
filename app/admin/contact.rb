ActiveAdmin.register Contact do
  controller do
    def permitted_params
      params.permit contact: [:name, :surname, :city, :country, :birthday, 
                              :about_info, :email, :order_number, 
                              :able_for_contact, :group, :own_gender, 
                              :search_for_gender, :structure_test_info, 
                              :image, :image_data, :level, :level_test_info]
    end
  end
end



      


