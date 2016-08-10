# encoding: utf-8
class UserNonverballyActionsMailer < ActionMailer::Base

  default from: 'be-in-pair@gmail.com'


  def the_room_of_current_user(user, room_url)
    @user          = user
    @room_url      = room_url
    mail(to: user.contact.email, subject: 'Ваша комната создана')    
  end 
    
  
  def new_incoming_request_for_open_communication(user_sender, user_receiver, room_url)
    @user_sender   = user_sender
    @user_receiver = user_receiver
    @room_url      = room_url
    mail(to: user_receiver.contact.email, subject: 'Вы получили новый запрос на общение')    
  end 
   

  def request_is_approved(user_sender, user_receiver, room_url)
    @user_sender   = user_sender
    @user_receiver = user_receiver
    @room_url      = room_url
    mail(to: user_receiver.contact.email, subject: 'Ваш запрос на общение одобрен')    
  end  

  def request_is_rejected(user_sender, user_receiver, room_url, link_with_contacts)
    @user_sender   = user_sender
    @user_receiver = user_receiver
    @link_with_contacts = link_with_contacts
    @room_url      = room_url
    mail(to: user_receiver.contact.email, subject: 'Запрос на общение отклонен')    
  end  


end
