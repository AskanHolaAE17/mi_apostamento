ActiveAdmin.register Article do
  controller do
    def permitted_params
      params.permit article: [:title, :description, :image, :code_name, 
                              :able, :translit, :description_meta,
                              :keywords_meta, :em, :h2, :title_tag, 
                              :number]
    end
  end
end



      


