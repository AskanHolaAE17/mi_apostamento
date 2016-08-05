# encoding: utf-8
class SecureMailer < ActionMailer::Base

  default from: 'be-in-pair@gmail.com'
  
  
  def wrong_url(details, counter, id_for_email_theme_string_begin)
    @details = details       
    @counter = counter
    id_for_email_theme_string_begin = id_for_email_theme_string_begin.to_s + ' - KIND ATTENTION: wrong url'
    mail(to: 'be-in-pair@gmail.com', subject: id_for_email_theme_string_begin)    
  end  
  
  def undefined_in_db(details, counter, id_for_email_theme_string_begin)
    @details = details
    @counter = counter       
    id_for_email_theme_string_begin = id_for_email_theme_string_begin.to_s + ' - KIND ATTENTION: undefined in DataBase'
    mail(to: 'be-in-pair@gmail.com', subject: id_for_email_theme_string_begin)        
  end

end
