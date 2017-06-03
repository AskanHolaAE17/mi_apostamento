class CreateSecurityOfMailings < ActiveRecord::Migration
  def change
    create_table :security_of_mailings do |t|
    
      t.string   :error_type
      t.string   :error_request
      t.text     :error_message

      t.timestamps null: false
    end
  end
end


