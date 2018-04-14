# encoding: utf-8
class UserPersonalConsultMailer < ActionMailer::Base

  default from: 'be-in-pair@gmail.com'
  
  
  def b_mail_to_consult_for_first_connection(user_personal_consult)
    @user_personal_consult = user_personal_consult            
    mail(to: 'be-in-pair@gmail.com', subject: 'Новый клиент на консультацию (психология)')
  end

   
end
