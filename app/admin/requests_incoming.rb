ActiveAdmin.register RequestsIncoming do
  controller do
    def permitted_params
      params.permit requests_incoming: [:user_id, :from, :status, :able]
    end
  end
end



      


