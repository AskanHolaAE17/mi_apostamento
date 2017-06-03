ActiveAdmin.register SecretQuestion do
  controller do
    def permitted_params
      params.permit secret_question: [:body]
    end
  end
end






      


