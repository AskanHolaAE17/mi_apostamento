class UpdateInfoConsultPriceInMeConstants < ActiveRecord::Migration


  @me_constant = MeConstant.find_by title: 'consult_price'
  @me_constant.update content: '350'  


end

