ActiveAdmin.register PreambleElement do
  controller do
    def permitted_params
      params.permit preamble_element: [:name, :body, :number, :article_number]     
    end
  end
end


