ActiveAdmin.register DbModelsExplanation do
  controller do
    def permitted_params
      params.permit db_models_explanation: [:the_model_name, :common_info, :details]                        
    end
  end
end



      


