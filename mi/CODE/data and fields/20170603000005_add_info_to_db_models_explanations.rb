class AddInfoToDbModelsExplanations < ActiveRecord::Migration

  

  DbModelsExplanation.create the_model_name: 'Requests For Communications', common_info: 'status', details: '00 STILL pending(waiting_for_an_answer) 11 STOP canceled(by sender) 10 YES accepted(agree be receiver) 01 NO rejected(NO - by receiver)'
  


end

