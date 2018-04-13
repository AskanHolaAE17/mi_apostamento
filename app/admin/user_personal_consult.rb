ActiveAdmin.register UserPersonalConsult do
  controller do
    def permitted_params
      params.permit user_personal_consult: [:user_site_id, :email, :name, :akey_short, :count_of_consults, :story_of_sessions]      
    end
  end
end



      


