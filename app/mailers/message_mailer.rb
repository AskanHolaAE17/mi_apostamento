# encoding: utf-8
class MessageMailer < ActionMailer::Base

  default from: 'be-in-pair@gmail.com'


  def new_income_message(user_sender, user_receiver, room_url)
    @user_sender   = user_sender
    @user_receiver = user_receiver
    @room_url      = room_url
    mail(to: @user_sender.email, subject: 'KIND: Новое сообщение')    
  end 

end
