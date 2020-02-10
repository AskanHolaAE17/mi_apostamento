ActiveAdmin.register TestsInfoPage do
  controller do
    def permitted_params
      params.permit tests_info_page: [:title, :msg, :translit]
    end
  end
end


