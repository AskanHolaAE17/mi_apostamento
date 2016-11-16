ActiveAdmin.register ShowFeedbackRequest do
  controller do
    def permitted_params
      params.permit show_feedback_request: [:user_id, :receiver, :status, 
                                            :able, :members]
    end
  end
end






      


