class AddInfoToMeConstants < ActiveRecord::Migration

  

  MeConstant.create title: 'root_path', content: 'http://kindrelations.com/'
  
  MeConstant.create title: 'site_title', content: 'Безопасные отношения'
  
  MeConstant.create title: 'pay_via_sandbox', content: '1'
  
  MeConstant.create title: 'aes_key', content: 'shpi7ic7ld8yj'
  
  MeConstant.create title: 'consult_price', content: '500'
  
  

end

