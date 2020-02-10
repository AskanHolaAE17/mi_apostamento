# encoding: utf-8
class OrderMailer < ActionMailer::Base

  default from: 'be-in-pair@gmail.com'

  
  def a_has_client_payed(order, order_current_test_link)
    @order = order            
    @order_current_test_link = order_current_test_link
    mail(to: @order.email, subject: 'KIND: Прохождение теста')    
  end
    
      
  def b_test_to_client_for_get_contacts_after_cool_pay(order, test_url)
    @order = order            
    @test_url = test_url
    mail(to: @order.email, subject: 'KIND: Психологически безопасные отношения - Пройдите тест')
  end


  def b_to_test_2_levels(order, link_with_test_2_levels)
    @order = order
    @link_with_test_2_levels = link_with_test_2_levels
    mail(to: @order.email, subject: 'KIND: Второй тест')
  end  


  def bx_2_events_do_you_want_to_db(order, link_2_events_do_you_want_to_db)
    @order         = order
    @link_2_events_do_you_want_to_db = link_2_events_do_you_want_to_db
    mail(to: @order.email, subject: 'KIND: 2 события')
  end

  
  def c_more_info_form(order, link_with_more_info_form, link_with_contacts_again)
    @order = order
    @link_with_more_info_form = link_with_more_info_form
    @link_with_contacts_again = link_with_contacts_again
    mail(to: @order.email, subject: 'KIND: Для поиска пары')
  end
  
  
  def d_see_contacts(order, link_with_contacts, disable_contact_link)
    @order = order
    @link_with_contacts = link_with_contacts
    @disable_contact_link = disable_contact_link
    mail(to: @order.email, subject: 'KIND: Страница с контактами')  
  end
  
  
  def e_ready_for_pay_consult(consult)
    @consult = consult
    mail(to: @consult.email, subject: 'KIND: Заказ консультации')  
  end    
    
  
  def f_consult_payed(consult)
    @consult = consult
    mail(to: @consult.email, subject: 'KIND: Консультация оплачена')  
  end    
      
end
