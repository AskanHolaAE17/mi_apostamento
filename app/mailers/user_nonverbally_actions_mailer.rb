# encoding: utf-8
class UserNonverballyActionsMailer < ActionMailer::Base

  default from: 'be-in-pair@gmail.com'


  def the_room_of_current_user(user, room_url)
    @user          = user
    @room_url      = room_url
    mail(to: user.contact.email, subject: 'KIND: Ваша комната с практическими рекомендациями создана')    
  end 
    
  
  def new_incoming_request_for_open_communication(user_sender, user_receiver, room_url)
    @user_sender   = user_sender
    @user_receiver = user_receiver
    @room_url      = room_url
    mail(to: user_receiver.contact.email, subject: 'KIND: Вы получили новый запрос на общение')    
  end 
   

  def request_is_approved(user_sender, user_receiver, room_url)
    @user_sender   = user_sender
    @user_receiver = user_receiver
    @room_url      = room_url
    mail(to: user_receiver.contact.email, subject: 'KIND: Ваш запрос на общение одобрен')    
  end  

  def request_is_rejected(user_sender, user_receiver, room_url, link_with_contacts)
    @user_sender   = user_sender
    @user_receiver = user_receiver
    @link_with_contacts = link_with_contacts
    @room_url      = room_url
    mail(to: user_receiver.contact.email, subject: 'KIND: Запрос на общение отклонен')    
  end  

  #_____________________________________________________________________________
  

  def new_incoming_request_for_open_feedback(user_sender, user_receiver, room_url)
    @user_sender   = user_sender
    @user_receiver = user_receiver
    @room_url      = room_url
    mail(to: user_receiver.contact.email, subject: 'KIND: Вы получили новый запрос на открытие обратных связей')    
  end 
   

  def request_for_open_feedback_is_approved(user_sender, user_receiver, room_url)
    @user_sender   = user_sender
    @user_receiver = user_receiver
    @room_url      = room_url
    mail(to: user_receiver.contact.email, subject: 'KIND: Ваш запрос на открытие обратных связей одобрен')    
  end  

  def request_for_open_feedback_is_rejected(user_sender, user_receiver, room_url, link_with_contacts)
    @user_sender   = user_sender
    @user_receiver = user_receiver
    @link_with_contacts = link_with_contacts
    @room_url      = room_url
    mail(to: user_receiver.contact.email, subject: 'KIND: Запрос на открытие обратных связей отклонен')    
  end  

end
