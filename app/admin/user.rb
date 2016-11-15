ActiveAdmin.register User do
  controller do
    def permitted_params
      params.permit user: [:id_in_base, :email, :name, :surname, :group, 
                           :akey, :active, 
                           :white_writing_able_users_ids_list,
                           :feedback_able_users_ids_list]      
    end
  end
end



      


