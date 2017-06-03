class AddCurrentTmpNewMessageLinkToMessages < ActiveRecord::Migration

  def change
    add_column  :messages, :current_tmp_new_message_link, :string
  end
  
end

