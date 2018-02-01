class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.boolean  "payed"
      t.string   "name"
      t.string   "email"
      t.string   "akey"
      t.decimal  "sum_for_pay"
      t.string   "when_payed"
      t.string   "akey_payed"
      t.string   "pay_link"      
      t.boolean  "sent_email_with_test", default: false
      t.boolean  "test_ended",           default: false
      t.boolean  "more_info_save",       default: false      
      t.boolean  "able",                 default: false      
      t.string   "group"
      
      t.timestamps                  
    end
  end
end



