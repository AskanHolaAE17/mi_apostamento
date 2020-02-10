ActiveAdmin.register QwStructSignal do
  controller do
    def permitted_params
      params.permit qw_struct_signal: [:qw_number, :field, :struct, :able]      
    end
  end
end






      


