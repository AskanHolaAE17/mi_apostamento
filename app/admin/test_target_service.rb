ActiveAdmin.register TestTargetService do
  controller do
    def permitted_params
      params.permit test_target_service: [:title, :body, :number, :able]
    end
  end
end


