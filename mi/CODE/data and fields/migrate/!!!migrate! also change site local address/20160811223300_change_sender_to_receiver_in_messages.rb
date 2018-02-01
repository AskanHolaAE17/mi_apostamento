class ChangeSenderToReceiverInMessages < ActiveRecord::Migration
  def change
    rename_column :messages, :sender, :receiver
  end
end

