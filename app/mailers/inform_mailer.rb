# encoding: utf-8
class InformMailer < ActionMailer::Base

  default from: 'be-in-pair@gmail.com'
  
  
  def if_contacts_null(contact)
    @contact = contact        
    mail(to: 'be-in-pair@gmail.com', subject: 'Клиент заплатил и все еще ждет контакты.')    
  end  

end
