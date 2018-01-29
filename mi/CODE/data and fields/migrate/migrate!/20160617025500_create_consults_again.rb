class CreateConsultsAgain < ActiveRecord::Migration
  def change
    create_table :consults do |t|
      t.string   :name
      t.string   :email   
      t.boolean  :payed,           default: false                    
      t.decimal  :sum_for_pay     
      t.string   :date1
      t.string   :time1      
      t.string   :date2      
      t.string   :time2      
      t.string   :selected_time
      t.string   :when_payed
      t.string   :akey_payed     
      t.string   :pay_link   
      t.boolean  :able,            default: true              
            
      t.timestamps                
    end
  end
end
