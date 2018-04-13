ActiveAdmin.register UserSite do
  controller do
    def permitted_params
      params.permit user_site: [:email, :name, :active, :akey_short, :common_sum]      
    end
  end
end



      


