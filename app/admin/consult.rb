ActiveAdmin.register Consult do
  controller do
    def permitted_params
      params.permit consult: [:name, :email, :payed, :sum_for_pay, 
                              :date1, :time1, :date2, :time2, :selected_time, 
                              :when_payed, :akey_payed, :pay_link, :able,
                              :link_if_unsaved, :sent_email_after_pay_for_waiting]
    end
  end
end



      


