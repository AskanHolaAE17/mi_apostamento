ActiveAdmin.register Room do
  controller do
    def permitted_params
      params.permit room: [:user_id, :id_in_base, :font_size, :tmp_income_key]      
    end
  end
end



      


