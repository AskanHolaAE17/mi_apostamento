class AddWhenStartsNewCounterToSecurityOfMailings < ActiveRecord::Migration

  def change
    add_column  :security_of_mailings, :when_starts_new_counter, :datetime
  end
  
end

