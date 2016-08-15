ActiveAdmin.register FeedbacksLevel do
  controller do
    def permitted_params
      params.permit feedbacks_level: [:title, :body]
    end
  end
end



      


