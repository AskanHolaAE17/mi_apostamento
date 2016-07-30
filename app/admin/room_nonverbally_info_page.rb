ActiveAdmin.register RoomNonverballyInfoPage do
  controller do
    def permitted_params
      params.permit room_nonverbally_info_page: [:title, :msg, :translit]
    end
  end
end






      


