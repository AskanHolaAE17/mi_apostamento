ActiveAdmin.register RequestsOutcoming do
  controller do
    def permitted_params
      params.permit requests_outcoming: [:user_id, :to, :status, :able]
    end    
  end
end



      


