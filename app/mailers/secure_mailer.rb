# encoding: utf-8
class SecureMailer < ActionMailer::Base

  default from: 'be-in-pair@gmail.com'
  
  
  def wrong_url(details, counter, id_for_email_theme_string_begin)
    @details = details       
    @counter = counter
    id_for_email_theme_string_begin = id_for_email_theme_string_begin.to_s + ' KIND ATTENTION: wrong url'
    mail(to: 'be-in-pair@gmail.com', subject: id_for_email_theme_string_begin)    
  end  

  
  def undefined_in_db(details, counter, id_for_email_theme_string_begin)
    @details = details
    @counter = counter       
    id_for_email_theme_string_begin = id_for_email_theme_string_begin.to_s + ' KIND ATTENTION: undefined in DataBase'
    mail(to: 'be-in-pair@gmail.com', subject: id_for_email_theme_string_begin)        
  end


  def personal_consult_first_request_is_created_by_bot(user_personal_consult, error_live)
    @user_personal_consult = user_personal_consult
    @error_live           = error_live
    mail(to: 'be-in-pair@gmail.com', subject: error_in_db.id.to_s + ' KIND ATTENTION: PersonalConsult Request is created by bot')        
  end


end
