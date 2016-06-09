require 'rsa'
require 'uri'
# encoding: utf-8
class ContactsController < ApplicationController

  before_action :set_main_page, only: [:more_info_form, :show]
#_____________________________________________________________________________________________________________________________________________

  
  
  def more_info_form
    @page       = Page.find_by_page :more_info_form  
    @site_title = MeConstant.find_by_title('site_title').content 

#_______________________________________________________________________________      


    order_info  = params[:order_info]
    
    
    
    #link_details_begin_for_url = order_info
    #link_details_begin_ascii_8 = URI.decode(link_details_begin_for_url)    
    #key_pair  = @key_pair      
    #order_info = key_pair.decrypt(link_details_begin_ascii_8)          
#_______________________________________________________________________________
      

                   
    order_info[order_info.length-1] = ''
    order_info  = Base64.decode64(order_info)        
#_______________________________________________________________________________



    order_id = ''
    order_akey_payed = ''
    
    for i in 0..order_info.length-1
      unless order_info[i].in? ('a'..'z')
        order_id += order_info[i]
      else
        @current_i = i.to_i + 1
        break
      end
    end    
#_______________________________________________________________________________        


        
    for i in @current_i..order_info.length - 1
      unless order_info[i] == '#'
        order_akey_payed += order_info[i]
      else
        break
      end  
    end        

    
#_______________________________________________________________________________        

    

    order = Order.find(order_id)    
    if order and order.akey_payed == order_akey_payed            
      @order = order
    else
      #Mail to Admin
      redirect_to '/'
    end       
#_______________________________________________________________________________        

    
    if order.more_info_save
      redirect_to root_path + 'info/kontaktnye_dannye_uzhe_sohraneny'
    end

#_______________________________________________________________________________        
        
    

    @contact = Contact.new              #-# less 5 strings down
    
    if Contact.find_by(order_number: order_id)
      @exist_contact = Contact.find_by(order_number: order_id)
    else  
      @exist_contact = Contact.new  
    end      

  end
#_____________________________________________________________________________________________________________________________________________




  
  def create    

    #-#order      = Order.find(params[:order_number])       
    
    #-#contact = Contact.find_by(order_number: params[:order_number])     
    #-#contact.update_attributes(contact_params.clone) 
    contact = Contact.new(contact_params)    
    order = Order.find(contact.order_number)
    
    contact.structure_test_info = order.structure_test_info    
    order.structure_test_info = ''        
    
    
    
    root_path  = MeConstant.find_by_title('root_path').content

#_______________________________________________________________________________


    
    #if order and order.more_info_save != true
    
    unless order.more_info_save    
    
    if contact.save        

    
      contacts_status = if order.group == 'GOOD GROUP'                     
        [2,4,6,8].shuffle.first.to_s
      else
        [1,3,5,7,9].shuffle.first.to_s      
      end

      plus_2_letters      = ('a'..'z').to_a.shuffle.first + 
                            ('a'..'z').to_a.shuffle.first
           
      contacts_details    = contacts_status               + 
                            order.id.to_s                 + 
                            plus_2_letters                + 
                            order.akey_payed                     



      contacts_details_encoded_64  = (Base64.encode64 contacts_details).chomp.delete("\n")
      contacts_details     = contacts_details_encoded_64 + '='



      link_with_contacts = root_path                      + 
                           'contacts/'                    + 
                           contacts_details                      
#_______________________________________________________________________________


      order.more_info_save = true
      order.save



      @contacts = if ( contacts_status.to_i % 2 == 0 )
        Contact.where( group: 'GOOD GROUP')
      else  
        Contact.where( group: 'BAD GROUP' )
      end        
    
      @contacts = @contacts.where.not(order_number: order.id)
    
      #unless @contacts.count == 0 
        OrderMailer.d_see_contacts(order, link_with_contacts).deliver      
      #end


      msg_page_before_show_contacts = root_path + 'info/pismo_so_ssylkoy_na_bazu'      
      #redirect_to link_with_contacts                         
      redirect_to msg_page_before_show_contacts
#_______________________________________________________________________________

          
    else   #if Contact notSave
      flash[:your_sex] = contact.own_gender
      flash[:search_for_gender] = contact.search_for_gender
    

      flash[:contact_name]            = contact.name
      #flash[:contact_surname]         = contact.surname
      flash[:contact_city]            = contact.city
      flash[:contact_country]         = contact.country
      flash[:contact_birthday]        = contact.birthday
      flash[:contact_about_info]      = contact.about_info
      
      flash[:contact_own_gender_male_checked]   = 'checked' if contact.own_gender == 'М'
      flash[:contact_own_gender_female_checked] = 'checked' if contact.own_gender == 'Ж'
      #flash[:contact_own_gender_other_checked]  = 'checked' if contact.own_gender == 'ЖМ'
      
      flash[:contact_search_for_gender_male_checked]   = 'checked' if contact.search_for_gender == 'М'
      flash[:contact_search_for_gender_female_checked] = 'checked' if contact.search_for_gender == 'Ж'
      flash[:contact_search_for_gender_both_checked]   = 'checked' if contact.search_for_gender == 'ЖМ'      
#_______________________________________________________________________________      
      
      
      anchor = ''
      contact.errors.each do |attr, msg|
        flash[:error_class_name]              = 'error_field' if attr == :name
        #flash[:error_class_surname]           = 'error_field' if attr == :surname
        flash[:error_class_own_gender]        = 'error_field' if attr == :own_gender
        flash[:error_class_city]              = 'error_field' if attr == :city
        flash[:error_class_country]           = 'error_field' if attr == :country
        flash[:error_class_birthday]          = 'error_field' if attr == :birthday
        flash[:error_class_search_for_gender] = 'error_field' if attr == :search_for_gender
        flash[:error_class_about_info]        = 'error_field' if attr == :about_info
                
                
                
        flash[:autofocus_name]      = false                
        #flash[:autofocus_surname]   = false         
        flash[:autofocus_city]      = false                
        flash[:autofocus_country]   = false         
        flash[:autofocus_birthday]  = false                
        flash[:about_info]          = false         
#_______________________________________________________________________________        
                        
                        
        if attr == :name
          flash[:autofocus_name] = true
        else
        
          #if attr == :surname
          #  flash[:autofocus_surname] = true
          #else
          
            if attr == :city
              flash[:autofocus_city] = true
            else
          
              if attr == :country
                flash[:autofocus_country] = true
              else
          
                if attr == :birthday
                  flash[:autofocus_birthday] = true
                else
          
                  if attr == :about_info
                    flash[:autofocus_about_info] = true
                  end                        
                end                        
              end            
            end            
          #end
        end                                               #attr == :name
#_______________________________________________________________________________

                        
        if attr == :name
          anchor = 'name'
        else  
        
          #if attr == :surname
          #  anchor = 'surname'
          #else  

            if attr == :own_gender
              anchor = 'own_gender'
            else  
          
              if attr == :city
                anchor = 'city'
              else  
            
                if attr == :country
                  anchor = 'country'
                else  
              
                  if attr == :birthday
                    anchor = 'birthday'
                  else  
                
                    if attr == :search_for_gender
                      anchor = 'search_for_gender'
                    else                  
                
                      if attr == :about_info
                        anchor = 'about_info'
                      end                            #attr == :about_info
                    end                              #attr == :search_for_gender   
                  end                                #attr == :birthday                                        
                end                                  #attr == :country                        
              end                                    #attr == :city      
            end                                      #attr == :own_gender                              
          #end                  
        end                                          #attr == :name
        
      end           #contact.errors.each
#_______________________________________________________________________________      
           
           
      letter                    = ('a'..'z').to_a.shuffle.first
      
      url_with_contacts_details = order.id.to_s      +
                                  letter             +        
                                  order.akey_payed   +
                                  '#'                +
                                  anchor
                                                                                                      
      url_with_contacts_details_encoded_64  = (Base64.encode64 url_with_contacts_details).chomp.delete("\n")
      url_with_contacts_details = url_with_contacts_details_encoded_64 + '=' 
      
      
      
      url_with_contacts         = root_path           +
                                 'much_form/'         + 
                                  url_with_contacts_details
                                               
             
      redirect_to url_with_contacts         
#_______________________________________________________________________________      
  end        #end Contact.save
    else        #if order.more_info_save    already
      flash[:notice]   = 'There is problem with your ID or Akey. Hm: Maybe you`re hacker, aren`t you?'
      redirect_to '/'
    end         #end   order.more_info_save    
  end
#_____________________________________________________________________________________________________________________________________________



  def show
  
    @page            = Page.find_by_page :contacts
  
  
  
    details_encoded  = params[:details]
    
    details_encoded[details_encoded.length-1] = ''
    details          = Base64.decode64(details_encoded)    
    
    
    
    
    status     = details[0].to_i
   
    order_id   = ''
    akey_payed = ''
    
    for i in 1..details.length-1
      unless details[i].in? ('a'..'z')
        order_id  += details[i].to_s
      else
        akey_start = i.to_i + 2
        break
      end
    end
#_______________________________________________________________________________


    
    for i in ( akey_start..details.length - 1 )
      akey_payed += details[i].to_s
    end     
    
    order = Order.find(order_id)   
    unless ( order and order.akey_payed == akey_payed )
      redirect_to '/'  
    end               
#_______________________________________________________________________________


    contact = Contact.find_by order_number: order_id         # current User
    
    @contacts = if ( status % 2 == 0 )
      Contact.where( group: 'GOOD GROUP')
    else  
      Contact.where( group: 'BAD GROUP' )
    end        

    
    @contacts = @contacts.where.not(order_number: order_id) # without current User
                                                            # all genders
    
#_______________________________________________________________________________


    if contact.search_for_gender == 'М' or contact.search_for_gender == 'Ж'     # if User searching just for ONE gender
      @contacts = @contacts.where(own_gender: contact.search_for_gender)        # set Contacts with ONE right for CurrentContact gender  
    end        
    
    
    @res_contacts = []
    @contacts.each do |c|
      if contact.own_gender.in? c.search_for_gender                             #leave just Contacts that like -> CurrentContact
        @res_contacts << c
      end
    end
    
    
    @contacts = @res_contacts
    
    
#_______________________________________________________________________________

    
    if @contacts.count == 0                                 # if DB with contacts is nill - inform Leader
      InformMailer.if_contacts_null(contact).deliver        
    end
  end
#_____________________________________________________________________________________________________________________________________________


  private
  
    def set_main_page
      @main_page  = MainPage.find(1)       
    end          

    def contact_params
      params.require(:contact).permit(:name, :own_gender, :city, :country, :birthday, :search_for_gender, :about_info, :email, :order_number, :able_for_contact, :group, :structure_test_info)
    end  
 
  
end
