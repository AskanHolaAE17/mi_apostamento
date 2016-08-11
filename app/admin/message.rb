ActiveAdmin.register Message do
  controller do
    def permitted_params
      params.permit message: [:user_id, :msg_type, :receiver, :title, 
                              :body, :spam, :important, :deleted, 
                              :able, :current_tmp_new_message_link]     
    end
  end
end


