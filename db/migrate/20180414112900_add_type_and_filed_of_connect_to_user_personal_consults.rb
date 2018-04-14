class AddTypeAndFiledOfConnectToUserPersonalConsults < ActiveRecord::Migration

  def change
    add_column  :user_personal_consults, :type_of_connection, :string
    add_column  :user_personal_consults, :connection_address, :string
  end
  
end

