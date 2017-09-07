class AddInfoTestPriceToMeConstants < ActiveRecord::Migration

  

  @element = MeConstant.find_by title: 'test_price'
  
  @element.update content: '98'  
  


end

