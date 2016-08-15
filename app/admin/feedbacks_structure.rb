ActiveAdmin.register FeedbacksStructure do
  controller do
    def permitted_params
      params.permit feedbacks_structure: [:title, :body]
    end
  end
end



      


