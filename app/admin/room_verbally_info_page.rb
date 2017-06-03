ActiveAdmin.register RoomVerballyInfoPage do
  controller do
    def permitted_params
      params.permit room_verbally_info_page: [:title, :msg, :translit]
    end
  end
end






      


