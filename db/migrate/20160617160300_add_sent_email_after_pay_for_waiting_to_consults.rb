class AddSentEmailAfterPayForWaitingToConsults < ActiveRecord::Migration
  def change
    add_column :consults, :sent_email_after_pay_for_waiting, :boolean, default: false
  end
end

