ActiveAdmin.register RequestsForCommunication do
  controller do
    def permitted_params
      params.permit requests_for_communication: [:user_id, :receiver, :status, :able]
    end
  end
end






      


