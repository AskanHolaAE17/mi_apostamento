ActiveAdmin.register QwLevelSignal do
  controller do
    def permitted_params
      params.permit qw_level_signal: [:qw_number, :field, :level, :able]      
    end
  end
end






      


