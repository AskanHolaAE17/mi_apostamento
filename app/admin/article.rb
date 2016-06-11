ActiveAdmin.register Article do
  controller do
    def permitted_params
      params.permit article: [:title, :description, :image, :code_name, :able]
    end
  end
end



      


