ActiveAdmin.register Message do
  controller do
    def permitted_params
      params.permit message: [:user_id, :msg_type, :sender, :title, 
                              :body, :spam, :important, :deleted, 
                              :able]     
    end
  end
end


