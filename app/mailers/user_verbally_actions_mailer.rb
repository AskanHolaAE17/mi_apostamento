# encoding: utf-8
class UserVerballyActionsMailer < ActionMailer::Base

  default from: 'be-in-pair@gmail.com'
  
  
  def new_incoming_msg(user_sender, user_receiver)
    @user_sender   = user_sender
    @user_receiver = user_receiver
    mail(to: user_receiver.email, subject: 'Вы получили новое сообщение')    
  end  

end
