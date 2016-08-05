class AddCounterToSecurityOfMailings < ActiveRecord::Migration

  def change
    add_column  :security_of_mailings, :counter, :integer, default: 0
  end
  
end

