require 'rsa'

require 'uri'
require "net/http"
# encoding: utf-8



class ContactsController < ApplicationController

  before_action :set_main_page, only: [:more_info_form, :show, :disable_contact_ask, :disable_contact]
  
#_____________________________________________________________________________________________________________________________________________

  
  
  def more_info_form
    @page       = Page.find_by_page :more_info_form  
    @site_title = MeConstant.find_by_title('site_title').content 
    
    @secret_questions = SecretQuestion.all

#_______________________________________________________________________________      


    order_info_full       = params[:order_info]
    order_info            = order_info_full.partition('__').first
    
#_______________________________________________________________________________      

    
    @redirect_to_room_flag   = order_info_full.partition('__').last || 'f'    # t/f      
    
#_______________________________________________________________________________      

    
    #link_details_begin_for_url = order_info
    #link_details_begin_ascii_8 = URI.decode(link_details_begin_for_url)    
    #key_pair  = @key_pair      
    #order_info = key_pair.decrypt(link_details_begin_ascii_8)          
    
#_______________________________________________________________________________     

                   
    #order_info[order_info.length-1] = ''
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

    
    if order.more_info_save                                                     # if MoreContactInfo has saved previously
      redirect_to root_path + 'info/kontaktnue_dannue_yzhe_sohranenu'           # Redirect immediately to explaining Msg
    end

#_______________________________________________________________________________        
        
    

    @contact = Contact.new              #-# less 5 strings down
    #@contact.order = order
    
    @date_select_year_start = Time.now.year - 100
    @date_select_year_end   = Time.now.year - 10    
    
    
    if Contact.find_by(order_number: order_id)
      @exist_contact = Contact.find_by(order_number: order_id)
      if @exist_contact.secret_answer_1 == 'a1711b' and @exist_contact.secret_answer_2 == 'b1711a'
    @exist_contact.name               = nil
    @exist_contact.surname            = nil
    @exist_contact.city               = nil
    @exist_contact.country            = nil
    @exist_contact.birthday           = nil
    @exist_contact.own_gender         = order.gender || nil
    @exist_contact.search_for_gender  = nil
    @exist_contact.about_info         = nil
    @exist_contact.deep_info          = nil
    @exist_contact.looking_for        = nil   
     
    @exist_contact.secret_question    = nil
    @exist_contact.secret_answer_1    = nil
    @exist_contact.secret_answer_2    = nil
    
    @exist_contact.able_for_contact   = false    
    
    @exist_contact.image_content_type = nil
    @exist_contact.image_file_name    = nil
    @exist_contact.image_file_size    = nil
    
    @exist_contact.ready_strong       = false
      end
    else  
      @exist_contact = Contact.new  
    end      

#____________________________________


    @contact_clone = ContactClone.find_by(order_number: order_id)  ||  ContactClone.new    

#____________________________________

    
    #@about_info = params[:contact][:about_info] if params[:contact]  and  params[:contact][:about_info]
    #@deep_info  = params[:contact][:deep_info]  if params[:contact]  and  params[:contact][:deep_info]
    
    #flash[:notice] =  ' '
    #flash[:notice] =  params[:contact]
    
  end
#_____________________________________________________________________________________________________________________________________________




  
  def create    

    root_path  = MeConstant.find_by_title('root_path').content

#_______________________________________________________________________________

    
    #-#order      = Order.find(params[:order_number])       
    
    #-#contact = Contact.find_by(order_number: params[:order_number])     
    #-#contact.update_attributes(contact_params.clone) 
    
    redirect_to_room_flag = params[:contact][:redirect_to_room_flag]   # t/f
    
#______________________________________

    
    order_id_form = params[:contact][:order_number]

    
    if Contact.find_by(order_number: order_id_form)
      contact = Contact.find_by order_number: order_id_form
      
    contact.name               = nil
    contact.surname            = nil
    contact.city               = nil
    contact.country            = nil
    contact.birthday           = nil
    contact.own_gender         = nil
    contact.search_for_gender  = nil
    
    contact.about_info         = nil
    contact.deep_info          = nil
    contact.looking_for        = nil    
    
    contact.secret_question    = nil
    contact.secret_answer_1    = nil
    contact.secret_answer_2    = nil
    
    contact.image_content_type = nil
    contact.image_file_name    = nil
    contact.image_file_size    = nil
    
    contact.ready_strong       = false                
      
      contact.update_attributes(contact_params)    
    else  
      contact = Contact.new(contact_params)    
    end    
        
    order   = Order.find(contact.order_number)
    
#_______________________________________________________________________________
    
    
    contact.order = order
    
    #contact.secret_question = '1' if contact.secret_question == '0'
    
    
    contact.struct_test_info = order.struct_test_info    
    order.struct_test_info = ''        

    contact.struct = order.struct
    order.struct = ''        
    
    contact.level = order.level
    order.level = ''        
    
    contact.level_test_info = order.level_test_info    
    order.level_test_info = ''    
    
    
      if contact.secret_question 
        sqw = contact.secret_question 
        sqw.gsub!('"',"'")
        sqw.gsub!('[',"")
        sqw.gsub!(']',"")
        sqw.gsub!("'","")      
        sqw.gsub!(" ","")                       
        contact.secret_question = sqw
      end  
                   

#_______________________________________________________________________________
    
    #if order and order.more_info_save != true
    
    unless order.more_info_save    

#________________________________________


      @contact_clone = (ContactClone.find_by order_number: order.id)  ||  ContactClone.new
    
      #@contact_clone = unless @contact_clone
        #ContactClone.new
      #end

      @contact_clone.update_attributes(about_info:   contact.about_info,                                 
                                       deep_info:    contact.deep_info,                                 
                                       looking_for:  contact.looking_for,     
          
                                       order_number: contact.order_number
                                       )
      
      #@contact_clone.update_attributes(name: contact.name,
      #                                 surname: contact.surname,
      #                                 city: contact.city,
      #                                 country: contact.country, 
      #                                 birthday: contact.birthday,
      #                                 about_info: contact.about_info,                                 
      #                                 deep_info: contact.deep_info,                                 
          
      #                                 own_gender: contact.own_gender,
      #                                 search_for_gender: contact.search_for_gender,
      #                                 secret_question: contact.secret_question,
      #                                 secret_answer_1: contact.secret_answer_1,
      #                                 secret_answer_2: contact.secret_answer_2,
          
      #                                 order_number: contact.order_number,
      #                                 email: contact.email,
      #                                 group: contact.group,
      #                                 able_for_contact: contact.able_for_contact
      #                                 )

#________________________________________

    
      if contact.save        
      
        @contact_clone.destroy       
        
#________________________________________


        contact.able_for_contact = true
        contact.save
      
#_______________________________________________________________________________    


    # RESIZE IMAGE
    
    #orig_geo = original_geometry = Paperclip::Geometry.from_file(contact.image(:original)).to_s
    #width = geo    
    
#_______________________________________________________________________________
    
    
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



      contacts_details  = (Base64.encode64 contacts_details).chomp.delete("\n")
      #contacts_details     = contacts_details_encoded_64 + '='



      link_with_contacts = root_path                      + 
                           'contacts/'                    + 
                           contacts_details                      
#_______________________________________________________________________________


      order.more_info_save = true
      order.akey           = akey
      order.save



      @contacts = if ( contacts_status.to_i % 2 == 0 )
        Contact.where( group: 'GOOD GROUP')
      else  
        Contact.where( group: 'BAD GROUP' )
      end        
    
      @contacts = @contacts.where.not(order_number: order.id)
      
#_____________________________________________


      disable_contact_params_hash = {
        :order_number => order.id,
        :order_akey   => order.akey,
        :contact_id   => contact.id
      }      
        
        d_c_params_json = JSON.generate(disable_contact_params_hash)
        d_c_params_encoded_64 = (Base64.encode64 d_c_params_json).chomp.delete("\n")
        #d_c_params_encoded = d_c_params_encoded_64 + '='
        disable_contact_params = d_c_params_encoded_64


    
      disable_contact_link = root_path + 'deactivate-contact/' + disable_contact_params     
      
      contact.link_for_disable_contact = disable_contact_link            

#_____________________________________________
      
    if contact.user_id == nil  
      user                 = User.new
      room                 = Room.new
    
        user.save
        room.save
    
      user.id_in_base    = user.id.to_s + id_in_base(3)
      room.id_in_base    = room.id.to_s + id_in_base(3)
      
    else
    
      user = User.find(contact.user_id)
      room = user.room
    end  

    
    user.email        = contact.email
    user.name         = contact.name
    user.surname      = contact.surname
    
    user.group        = contact.group    
      user.contact    = contact
      user.room       = room
    
    user.save      
      contact.save
      room.save
      
#______________________________________


    # ROOM

      plus_2_letters           = ('a'..'z').to_a.shuffle.first + 
                                 ('a'..'z').to_a.shuffle.first
                                 
      plus_3_letters           = ('a'..'z').to_a.shuffle.first + 
                                 ('a'..'z').to_a.shuffle.first + 
                                 ('a'..'z').to_a.shuffle.first                                       
           
      room_details             = user.id.to_s                           + 
                                 plus_2_letters                         + 
                                 room.id.to_s                           +
                                 '_'                                    +
                                 user.id_in_base.to_s[0, 2]             +
                                 plus_3_letters                         + 
                                 room.id_in_base.to_s[0, 3]                                                      


      devider_central_position = room_details.index('_')            
      devider_start_position   = devider_central_position.to_i / 2      
      
      time_now_min             = Time.now.min
      devider_end_position     = if time_now_min % 2 == 0
        room_details.length-3
      else  
        room_details.length-2 
      end  
      
      room_details.insert(devider_start_position, '_')
      room_details.insert(devider_end_position, '_')
      


      room_details_encoded_64  = (Base64.encode64 room_details).chomp.delete("\n")
      room_details             = room_details_encoded_64 



      room_url                 = root_path                      + 
                                'room/'                         + 
                                 room_details                                                         
      
#_____________________________________________
    
    
      #unless @contacts.count == 0 
        OrderMailer.d_see_contacts(order, link_with_contacts, disable_contact_link).deliver
        #UserNonverballyActionsMailer.the_room_of_current_user(user, room_url).deliver
      #end


      msg_page_before_show_contacts = root_path + 'info/pismo_so_ssulkoy_na_bazy'      

#_____________________________________________


      if redirect_to_room_flag == 't' 
      
        msg_page_before_show_contacts  =  room_url 
        flash[:more_info_form_save]    =  'Вы добавились в базу и теперь можете видеть анкеты других участников'
        
      end   # if redirect_to_room_flag == 't'             
      
#_____________________________________________

      
      #redirect_to link_with_contacts                                           
      
      redirect_to msg_page_before_show_contacts
      
#_______________________________________________________________________________

          
    else   # unless contact.save

#_____________________________________________


      @contact_clone.save

#_____________________________________________

    
      flash[:contact_name]            = contact.name.to_s[0..398]
      flash[:contact_surname]         = contact.surname.to_s[0..398]
      flash[:contact_city]            = contact.city.to_s[0..398]
      flash[:contact_country]         = contact.country.to_s[0..398]
      
      flash[:contact_birthday_day]    = contact.birthday.strftime("%d %m %Y").split[0]
      flash[:contact_birthday_month]  = contact.birthday.strftime("%d %m %Y").split[1]
      flash[:contact_birthday_year]   = contact.birthday.strftime("%d %m %Y").split[2]

      #flash[:own_gender] = contact.own_gender
      #flash[:search_for_gender] = contact.search_for_gender
      
      flash[:contact_own_gender_male_checked]          = 'checked' if contact.own_gender == 'М'
      flash[:contact_own_gender_female_checked]        = 'checked' if contact.own_gender == 'Ж'
      #flash[:contact_own_gender_other_checked]         = 'checked' if contact.own_gender == 'ЖМ'
      
      flash[:contact_search_for_gender_male_checked]   = 'checked' if contact.search_for_gender == 'М'
      flash[:contact_search_for_gender_female_checked] = 'checked' if contact.search_for_gender == 'Ж'
      flash[:contact_search_for_gender_both_checked]   = 'checked' if contact.search_for_gender == 'ЖМ'      
      
      
      
      #flash[:contact_about_info]      = contact.about_info
      #flash[:contact_deep_info]       = contact.deep_info                       
            
      ### ОТЛАДКА
      #flash[:notice] =  ' '
      #flash[:notice] += ' contact.about_info'
      #flash[:notice] += ' is set;'             if contact.about_info
      #flash[:notice] += ' is NOT set;'         unless contact.about_info
      
      #flash[:notice] += ' contact.deep_info'
      #flash[:notice] += ' is set;'             if contact.deep_info
      #flash[:notice] += ' is NOT set;'         unless contact.deep_info                  
      
      #flash[:notice] += ' params[:contact][:about_info]'
      #flash[:notice] += ' is set;'             if params[:contact][:about_info]
      #flash[:notice] += ' is NOT set;'         unless params[:contact][:about_info]          
      
      #flash[:notice] += ' params[:contact][:deep_info]'
      #flash[:notice] += ' is set;'             if params[:contact][:deep_info]
      #flash[:notice] += ' is NOT set;'         unless params[:contact][:deep_info]            
      ###      

      if sqw
        sqw = sqw.split(",")         
        sqw.each  do |sqw|
	        flash['contact_secret_question_' + sqw.to_s]   = 'checked' 	      
        end	 
      end     
           
      
      flash[:contact_secret_answer_1]        = contact.secret_answer_1.to_s[0..398]      
      flash[:contact_secret_answer_2]        = contact.secret_answer_2.to_s[0..398]
      
      flash[:contact_ready_strong_checked]   = true if contact.ready_strong == true
      
      
      flash[:contact_redirect_to_room_flag]  = contact.redirect_to_room_flag       
      
#_______________________________________________________________________________      
      
              
      anchor = ''
      contact.errors.each do |attr, msg|
        flash[:error_class_name]              = 'error_field' if attr == :name
        flash[:error_class_surname]           = 'error_field' if attr == :surname
        flash[:error_class_city]              = 'error_field' if attr == :city
        flash[:error_class_country]           = 'error_field' if attr == :country
        flash[:error_class_birthday]          = 'error_field' if attr == :birthday
        
        flash[:error_class_own_gender]        = 'error_field' if attr == :own_gender        
        flash[:error_class_search_for_gender] = 'error_field' if attr == :search_for_gender
        
        flash[:error_class_about_info]        = 'error_field' if attr == :about_info
        flash[:error_class_deep_info]         = 'error_field' if attr == :deep_info        
        flash[:error_class_looking_for]         = 'error_field' if attr == :looking_for                
        flash[:error_class_image]             = 'error_field' if attr == :image
        flash[:error_class_image]             = 'error_field'
        
        flash[:error_class_secret_question]   = 'error_field' if attr == :secret_question
        flash[:error_class_secret_answer_1]   = 'error_field' if attr == :secret_answer_1                
        flash[:error_class_secret_answer_2]   = 'error_field' if attr == :secret_answer_2
        
        flash[:error_class_ready_strong]      = 'error_field' if attr == :ready_strong               

 
                
        flash[:autofocus_name]      = false                
        flash[:autofocus_surname]   = false         
        flash[:autofocus_city]      = false                
        flash[:autofocus_country]   = false         
        flash[:autofocus_birthday]  = false
        
        flash[:own_gender]          = false   
        flash[:search_for_gender]   = false      
                     
        flash[:about_info]          = false         
        flash[:deep_info]           = false           
        flash[:looking_for]         = false                   
        flash[:image]               = false   
              
        flash[:secret_question]     = false
        flash[:secret_answer_1]     = false   
        flash[:secret_answer_2]     = false      
        
        flash[:ready_strong]        = false              
                          
#_______________________________________________________________________________        
                        
                        
      unless @skip_autofocus                  
        if attr == :name
          flash[:autofocus_name] = true
          @skip_autofocus = true
        else
        
          if attr == :surname
            flash[:autofocus_surname] = true
          else
          
            if attr == :city
              flash[:autofocus_city] = true
              @skip_autofocus = true
            else
          
              if attr == :country
                flash[:autofocus_country] = true
                @skip_autofocus = true
              else
          
                if attr == :birthday
                  flash[:autofocus_birthday] = true
                  @skip_autofocus = true
                else
          
          
                  if attr == :about_info
                    flash[:autofocus_about_info] = true
                    @skip_autofocus = true
                  else
                    if attr == :deep_info
                      flash[:autofocus_deep_info] = true
                      @skip_autofocus = true
                    else                  
                      if attr == :image
                        flash[:autofocus_image] = true                    
                        @skip_autofocus = true
                      else
                      
                      
                        if attr == :own_gender
                          flash[:autofocus_own_gender] = true
                          @skip_autofocus = true
                        else
                          if attr == :search_for_gender
                            flash[:autofocus_search_for_gender] = true
                            @skip_autofocus = true
                          else
          
                      
                            if attr == :secret_question
                              flash[:autofocus_secret_question] = true
                              @skip_autofocus = true
                            else                  
                              if attr == :secret_answer_1
                                flash[:autofocus_secret_answer_1] = true
                                @skip_autofocus = true
                              else                  
                                if attr == :secret_answer_2
                                  flash[:autofocus_secret_answer_2] = true
                                  @skip_autofocus = true
                                else
                                  if attr == :looking_for
                                    flash[:autofocus_looking_for] = true
                                    @skip_autofocus = true
                                  else
                                    if attr == :ready_strong
                                      flash[:autofocus_ready_strong] = true
                                      @skip_autofocus = true
                                    end                                     
                                  end                                             
                                end                                            
                              end                        
                            end            #attr == :secret_question              
          
          
                          end
                        end                      #attr == :own_gender
          
                        
                      end                                            
                    end  
                  end                                 #attr == :about_info
          
                  
                end                        
              end            
            end            
          end
        end                                               #attr == :name
      end          #skip autofocus
        
#_______________________________________________________________________________


      unless @skip_anchor
        if attr == :name
          anchor = '1'
          @skip_anchor = true
        else  
        
          if attr == :surname
            anchor = '2'
          else  

            if attr == :city
              anchor = '3'
              @skip_anchor = true
            else  
          
              if attr == :country
                anchor = '4'
                @skip_anchor = true
              else  
            
                if attr == :birthday
                  anchor = '5'
                  @skip_anchor = true
                else  
              
              
                  if attr == :own_gender
                    anchor = '6'
                    @skip_anchor = true
                  else  
                
                    if attr == :search_for_gender
                      anchor = '7'
                      @skip_anchor = true
                    else                  
                
                
                      if attr == :about_info
                        anchor = '8'
                        @skip_anchor = true
                      else 
                        if attr == :deep_info
                          anchor = '9'
                          @skip_anchor = true
                        else                        
                          if attr == :looking_for
                            anchor = '10'                      
                            @skip_anchor = true
                          else                          
                        
                            if attr == :image
                              anchor = '11'                      
                              @skip_anchor = true
                            else  
                            
                            
                              if attr == :secret_question
                                  anchor = '12'                      
                                  @skip_anchor = true
                              else
                                if attr == :secret_answer_1
                                  anchor = '13'                      
                                  @skip_anchor = true
                                else
                                  if attr == :secret_answer_2
                                    anchor = '14'                      
                                    @skip_anchor = true
                                  else
                                    if attr == :ready_strong
                                      anchor = '15'                      
                                      @skip_anchor = true
                                    end                                    
                                  end
                                end
                              end    
                            
                            
                            end                          #attr == :image
                          end  
                        end  
                      end                            #attr == :about_info
                      
                    end                              #attr == :search_for_gender   
                  end                                #attr == :own_gender                                        
                end                                  #attr == :birthday                        
              end                                    #attr == :country      
            end                                      #attr == :city                              
          end                  
        end                                          #attr == :name
        end    #skip_anchor
      end           #contact.errors.each      
      
#_______________________________________________________________________________      
           
           
      letter                    = ('a'..'z').to_a.shuffle.first
      
      url_with_contacts_details = order.id.to_s      +
                                  letter             +        
                                  order.akey_payed   
                                                                                                      
      url_with_contacts_details  = (Base64.encode64 url_with_contacts_details).chomp.delete("\n")
      #url_with_contacts_details = url_with_contacts_details_encoded_64 + '=' 
      
      
      
      url_with_contacts         = root_path           +
                                 'much_form/'         + 
                                  url_with_contacts_details +
                                  '#'                +
                                  anchor
                                               
#______________________________________


      #params = { 
      #           about_info: contact.about_info, 
      #           deep_info:  contact.deep_info
      #           #button1:    'Submit'                 
      #         } 
                
                
      #x = Net::HTTP.post_form(URI.parse('url_with_contacts'), params)
      #puts x.body
      
#______________________________________

             
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
   
 
    # For Consult FORM
    @sum_for_pay = MeConstant.find_by(title: 'consult_price').content  
  
  
    @page            = Page.find_by_page :contacts
    @consult         = Consult.new     
  
#_______________________________________________________________________________

  
    @details_encoded  = params[:details]
    
    #@details_encoded[@details_encoded.length-1] = ''    
    #flash[:contact_details_reload] = params[:details]   # contact_details_for_contact_show_page_reload
    details                 = Base64.decode64(@details_encoded)    
#?????????????????    

#    details_array    = details_from_url_to_array(details)
    
#    order_id         = details_array.first     
#    order_akey_payed = details_array.last
    
#_______________________________________________________________________________
               
    
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


    # show IF current contact active (able)
    check_is_contact_able = Contact.find_by(order_number: order_id)    
    
    unless check_is_contact_able.able_for_contact
      redirect_to root_path + 'info/stranitsa_ne_otkruta'
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


    contact                   = Contact.find_by order_number: order_id         # current User
    @user                     = User.find(contact.user_id)
    ###Request
    #@request = requests_for_communication = RequestsForCommunication.new    
    @request                  = @user.requests_for_communications.build
    @requests_of_current_user = @user.requests_for_communications

#_______________________________________________________________________________
    
    
    @contacts = Contact.all
    
    #@contacts = if ( status % 2 == 0 )
    #  Contact.where( group: 'GOOD GROUP')
    #else  
    #  Contact.where( group: 'BAD GROUP' )
    #end        

    @contacts = @contacts.where(able_for_contact: true)     # just activated Contacts
    @contacts = @contacts.where.not(order_number: order_id) # without current User
        
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
    
    
    @contacts         = @res_contacts              
    
#_______________________________________________________________________________

    
    if @contacts.count == 0                                 # if DB with contacts is nill - inform Leader
      InformMailer.if_contacts_null(contact).deliver        
    end
    
#_______________________________________________________________________________

    
    #MESSAGE    
    @sender_id         = @user.id.to_s
    @message           = @user.messages.build    
    @message_letter    = ('a'..'z').to_a.shuffle.first        
    
    user_id_in_base    = @user.id_in_base.to_s
    id_in_base_begin   = user_id_in_base[0,2]
    id_in_base_end     = user_id_in_base[2, user_id_in_base.length-1]
    
    message_details    = id_in_base_begin               +
                         '_'                            +
                         id_in_base_end                 +
                         ('a'..'z').to_a.shuffle.first  +
                         '_'                            
                         
                                                                                                      
    #message_details    = (Base64.encode64 message_details).chomp.delete("\n")
    
    @message_path_new  = root_path + 'message_new/' + message_details         
        
#______________________________________


      current_tmp_new_message_link_origin = ''
      details.each_char.with_index do |ch, i|
        unless ch == '_'
          current_tmp_new_message_link_origin += ch
        else
        
          @url_next = i + 1
          break
        end
      end      
      
      @url_next = details[@url_next.. -1]
      details = current_tmp_new_message_link_origin
      @current_tmp_new_message_link = details + '_contacts'

#______________________________________


    # NAVIGATION MENU - ROOM
    navigation_menu_room(@user, 'co')

    
  end
  
#_____________________________________________________________________________________________________________________________________________





  def link_with_contacts_again
  
    root_path  = MeConstant.find_by_title('root_path').content
    
#_______________________________________________________________________________

    
    details64        = params[:details]
    details          = Base64.decode64(details64)    
    details_array    = details_from_url_to_array(details)
    
    order_id         = details_array.first     
    order_akey_payed = details_array.last
    
    
    order         = Order.find(order_id)
        
#_______________________________________________________________________________    

  
    if order and order.akey_payed[0,3] == order_akey_payed and order.more_info_save

      contact       = Contact.find(order.contact_id)        
  
#_______________________________________________________________________________

  
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

#_______________________________________________________________________________


      contacts_details  = (Base64.encode64 contacts_details).chomp.delete("\n")
      #contacts_details     = contacts_details_encoded_64 + '='



      link_with_contacts = root_path                      + 
                           'contacts/'                    + 
                           contacts_details                 
                           
#_______________________________________________________________________________


      disable_contact_params_hash = {
        :order_number => order.id,
        :order_akey   => order.akey,
        :contact_id   => contact.id
      }      
        
        d_c_params_json = JSON.generate(disable_contact_params_hash)
        d_c_params_encoded_64 = (Base64.encode64 d_c_params_json).chomp.delete("\n")
        #d_c_params_encoded = d_c_params_encoded_64 + '='
        disable_contact_params = d_c_params_encoded_64


    
      disable_contact_link = root_path + 'deactivate-contact/' + disable_contact_params     

#_______________________________________________________________________________

                           
      OrderMailer.d_see_contacts(order, link_with_contacts, disable_contact_link).deliver

      msg_page_before_show_contacts = root_path + 'info/pismo_so_ssulkoy_na_bazy'      
    else  
      
#_______________________________________________________________________________

      
      redirect_letter          = ('a'..'z').to_a.shuffle.first
      link_details             = order.id.to_s                  + 
                                 redirect_letter                + 
                                 '&'                            +
                                 order.akey_payed[0,3]

      
      link_details_encoded  = (Base64.encode64 link_details).chomp.delete("\n")
      #link_details_encoded     = link_details_encoded_64 + '=' 

            
      next_page_after_test_2_level = link_with_more_info_form = root_path + 'much_form/' + link_details_encoded                       
      
#_______________________________________________________________________________
      
      
      msg_page_before_show_contacts = root_path + 'info/informatsiya_eshche_ne_zapolnena'
    end 
 
      redirect_to msg_page_before_show_contacts
                           
  end

#_____________________________________________________________________________________________________________________________________________


  def disable_contact_ask
    
    @page       = Page.find_by_page :more_info_form  
    @site_title = MeConstant.find_by_title('site_title').content   
        
    @deactive_link = root_path + 'de-activate-contact/' + params[:deactive_params]
    
  end

#_____________________________________________________________________________________________________________________________________________


  def disable_contact
    @page       = Page.find_by_page :more_info_form  
    @site_title = MeConstant.find_by_title('site_title').content     
    root_path  = MeConstant.find_by_title('root_path').content    
      

    # disable_contact_params is dcp
    dcp_encoded  = params[:deactive_params]
    #dcp_encoded[dcp_encoded.length-1] = ''
    dcp_json     = Base64.decode64(dcp_encoded)    
    disable_contact_params_hash       = JSON.parse(dcp_json)    
    
    contact_id   = disable_contact_params_hash['contact_id'].to_i    
    order_number = disable_contact_params_hash['order_number'].to_i
    order_akey   = disable_contact_params_hash['order_akey']
    
    
    contact = Contact.find(contact_id)      
    order   = Order.find(order_number)    
    user    = User.find(contact.user_id)
    
    if contact and order and contact.order_number == order_number and order.akey == order_akey
      user.active                      = false
      user.save
            
      contact.able_for_contact         = false
      contact.link_for_disable_contact = ''
      contact.save      
      
      redirect_to root_path + 'info/dannue_ydalenu_iz_bazu'
    else
      
      #MailToAdmin    
      redirect_to '/'
      
    end
  
  
  end  

#_______________________________________________________________________________



  private
  
    def set_main_page
      @main_page  = MainPage.find(1)       
    end          

    def contact_params
      params.require(:contact).permit(:name, :surname, :own_gender, :city, :country, :birthday, :search_for_gender, :about_info, :email, :order_number, :able_for_contact, :group, :structure_test_info, :level, :level_test_info, :link_for_disable_contact, :image, :image_file_name, :image_content_type, :image_file_size, :image_updated_at, :utf8,:_method, :authenticity_token, :commit, :id, :deep_info, :looking_for, :user_id, :secret_answer_1, :secret_answer_2, :structure, :ready_strong, :redirect_to_room_flag, :secret_question => [])
    end  
 
  
end

