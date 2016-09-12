ActiveAdmin.register Order do
  controller do
    def permitted_params
      params.permit order: [:payed, :name, :email, :akey, :pay_link, 
                            :sum_for_pay, :when_payed, :akey_payed, 
                            :able, :sent_email_with_test, :group, 
                            :structure_test_info, :level, :test_1_ended, 
                            :test_2_ended, :level_test_info, :contact_id, 
                            :structure, :current_qw_level, :current_qw_struct, 
                            :current_test_link]
    end
  end
end


      


