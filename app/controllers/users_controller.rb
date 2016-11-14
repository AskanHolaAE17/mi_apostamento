class UsersController < ApplicationController



before_action :set_root, :set_info, only: [:show_in_db, :off_in_db]

#_______________________________________________________________________________    


  def does_user_want_to_db
  
    @main_page  = MainPage.find(1)       
    @page       = Page.find_by_page :info
  
#__________________________________________    

    
    details  = params[:details].to_s
    full_id = details.clone
    details[details.length-2] = ''
    order_id = details
    order = Order.find(order_id)
    
#__________________________________________    


    if Contact.find_by(order_number: order.id)        
      contact = Contact.find_by(order_number: order.id)
      user = User.find(contact.user_id)
    else  
    
#__________________________________________    

    
      contact = Contact.new  
    
    
    contact.struct_test_info = order.struct_test_info    
    #-order.struct_test_info = ''        

    contact.struct = order.struct
    #-order.struct = ''        
    
    contact.level = order.level
    #-order.level = ''        
    
    contact.level_test_info = order.level_test_info    
    #-order.level_test_info = ''
    
    contact.order = order      

          
    contact.email = order.email
    contact.group = order.group
    contact.order_number = order.id
    
    contact.name               = order.name
    contact.surname            = 'a'    
    contact.city               = 'a'
    contact.country            = 'a'
    
    contact.birthday           = 'September 16, 1990'
    contact.own_gender         = order.gender  ||  'a'
    contact.search_for_gender  = 'ЖМ'.delete(order.gender.to_s)  ||  'ЖМ'
    
    contact.about_info         = 'a'
    contact.about_info         = 'a'
    contact.deep_info          = 'a'
    contact.looking_for        = 'a'    
    
    contact.secret_question    = '1,2'
    contact.secret_answer_1    = 'a1711b'
    contact.secret_answer_2    = 'b1711a'
    
    contact.able_for_contact   = false    
    
    contact.image_content_type = 'image/jpeg'
    contact.image_file_name    = '002.jpg'
    contact.image_file_size    = '97820'
    
    contact.ready_strong       = true
    
    
    order.save
    contact.save    
    
    
      user                 = User.new
      room                 = Room.new     
      
        user.save
        room.save
    
      user.id_in_base    = id_in_base_with_id(3, user.id.to_s)      
      room.id_in_base    = id_in_base_with_id(3, room.id.to_s)                
      
      user.email         = contact.email
      user.name          = contact.name      
    
      user.group         = contact.group    
      user.room          = room      
      user.contact       = contact
    
        user.save      
        room.save
      end  
      
#__________________________________________    

      
    room_url = room_url_def(user.id)
        
#__________________________________________    

        
    unless UserNonverballyActionsMailer.the_room_of_current_user(user, room_url).try(:deliver)            
      unless UserNonverballyActionsMailer.the_room_of_current_user(user, room_url).try(:deliver)
        unless UserNonverballyActionsMailer.the_room_of_current_user(user, room_url).try(:deliver)
        
          UserNonverballyActionsMailer.the_room_of_current_user(user, room_url).try(:deliver)
        
        end
      end
    end   # unless UserNonverballyActionsMailer.the_room_of_current_user(user, room_url).try(:deliver)                

#__________________________________________    

  
      redirect_letter          = ('a'..'z').to_a.shuffle.first
      link_details             = order.id.to_s               + 
                                 redirect_letter             + 
                                 order.akey_payed

#__________________________________________    


      link_details_encoded_64  = (Base64.encode64 link_details).chomp.delete("\n")  
    
#__________________________________________    

      
    @yes_want_to_db       = root_path + 'much_form/' + link_details_encoded_64  
        
    @no_doesnt_want_to_db = root_path + 'room_sent/' + full_id
  
  end
  
#_______________________________________________________________________________

      
  def room_url_without_added_to_base
   
    root_path = MeConstant.find_by_title('root_path').content
   
#__________________________________________    

   
    details   = params[:details].to_s
    details[details.length-2] = ''
    order_id  = details
    order     = Order.find(order_id)  
    
#__________________________________________    


    if order    
    #if Contact.find_by(order_number: order.id)        
    #  contact = Contact.find_by(order_number: order.id)
    #  user = User.find(contact.user_id)
    #else  
    #  contact = Contact.new  
    
    
    #contact.struct_test_info = order.struct_test_info    
    ##-order.struct_test_info = ''        

    #contact.struct = order.struct
    ##-order.struct = ''        
    
    #contact.level = order.level
    ##-order.level = ''        
    
    #contact.level_test_info = order.level_test_info    
    ##-order.level_test_info = ''
    
    #contact.order = order      

          
    #contact.email = order.email
    #contact.group = order.group
    #contact.order_number = order.id
    
    #contact.name               = order.name
    #contact.surname            = 'a'    
    #contact.city               = 'a'
    #contact.country            = 'a'
    
    #contact.birthday           = 'September 16, 1990'
    #contact.own_gender         = order.gender  ||  'a'
    #contact.search_for_gender  = 'ЖМ'.delete(order.gender.to_s)  ||  'ЖМ'
    
    #contact.about_info         = 'a'
    #contact.about_info         = 'a'
    #contact.deep_info          = 'a'
    #contact.looking_for        = 'a'    
    
    #contact.secret_question    = '1,2'
    #contact.secret_answer_1    = 'a1711b'
    #contact.secret_answer_2    = 'b1711a'
    
    #contact.able_for_contact   = false    
    
    #contact.image_content_type = 'image/jpeg'
    #contact.image_file_name    = '002.jpg'
    #contact.image_file_size    = '97820'
    
    
    #order.save
    #contact.save    
    
    
    #  user                 = User.new
    #  room                 = Room.new     
      
    #    user.save
    #    room.save
    
    #  user.id_in_base    = user.id.to_s + id_in_base(3)
    #  room.id_in_base    = room.id.to_s + id_in_base(3)          
      
    #  user.email         = contact.email
    #  user.name          = contact.name      
    
    #  user.group         = contact.group    
    #  user.room          = room      
    #  user.contact       = contact
    
    #    user.save      
    #    room.save
    #end
      
      
    #room_url = room_url_def(user.id)
    
    
    #UserNonverballyActionsMailer.the_room_of_current_user(user, room_url).try(:deliver)      
    
    #@info_msg = (RoomNonverballyInfoPage.find_by_translit: 'ssulka_na_komnaty').msg
    
        
#__________________________________________    


#__________________________________________
      

      # Creation of LINK: more_info_form
      # for more_info_form mailing
      redirect_letter          = ('a'..'z').to_a.shuffle.first
      link_details             = order.id.to_s               + 
                                 redirect_letter             + 
                                 order.akey_payed
      link_details_encoded_64  = (Base64.encode64 link_details).chomp.delete("\n").delete('=')

      
      link_with_more_info_form = root_path + 'much_form/' + link_details_encoded_64                            
      
#__________________________________________


      plus_2_letters           = ('a'..'z').to_a.shuffle.first + 
                                 ('A'..'Z').to_a.shuffle.first
                                                                                                   
      
      details                  = order.id.to_s                 + 
                                 plus_2_letters                + 
                                 '&'                           +
                                 order.akey_payed[0,3]                
                                 
                                 
      details  = (Base64.encode64 details).chomp.delete("\n").delete('=')                                 
      
      
      link_with_contacts_again = root_path                     + 
                                'show-contacts/'               + 
                                 details                       
      
#__________________________________________
      
      
      unless order.test_1_ended
        
        
        unless OrderMailer.c_more_info_form(order, link_with_more_info_form, link_with_contacts_again).try(:deliver)      
          unless OrderMailer.c_more_info_form(order, link_with_more_info_form, link_with_contacts_again).try(:deliver)      
            unless OrderMailer.c_more_info_form(order, link_with_more_info_form, link_with_contacts_again).try(:deliver)      
            
              OrderMailer.c_more_info_form(order, link_with_more_info_form, link_with_contacts_again).try(:deliver)      
              
            end
          end
        end   # unless OrderMailer.c_more_info_form(order, link_with_more_info_form, link_with_contacts_again).try(:deliver)            
        
        
      end   # unless order.test_1_ended              
            
#__________________________________________      

     
      order.test_1_ended     = true      

     
#__________________________________________      

        
      order.save

#__________________________________________

  
      redirect_to root_path + 'room_info/' + 'ssulka_na_komnaty'


    else   # unless order    
    
      redirect_to root_path + 'info/' + 'dannue_receive_obrabotanu'  
      
    end   # if order    
    
  end  

#_______________________________________________________________________________


  def create
  end

#_______________________________________________________________________________


  def show_off_in_db
  
    details_full_with_flag = params[:details]
    
    flag_in_from           = details_full_with_flag.first
    details_full           = details_full_with_flag[1..details_full_with_flag.length-1]
    
    details_64             = details_full.partition('__').first
    details                = Base64.decode64 details_64
    
#______________________________________
    
    
    # deviding str
    
    full              = details

    details           = full[0..full.length-2]
        
    user_id_len       = full.last.to_i     
    user_id           = details[0..user_id_len-1]

    user_code         = details[user_id_len..details.length-1]
        
#______________________________________


    user_id     = user_id
    user_code   = user_code
    
    user        = User.find(user_id)
    
#______________________________________

  
    if user
      user_id_in_base     = user.id_in_base 
      user_id_in_base_len = user_id_in_base.length
    end

    
    if user and user.id_in_base[user_id_in_base_len-4..user_id_in_base_len-2] == user_code
               
#______________________________________


      # DEF HANDLING                
      
      if flag_in_from == 'i' 
      
        user.contact.able_for_contact = true
        flash[:in_from_db_succes] = 'Вы добавились в базу и теперь можете видеть анкеты других участников.'                
      else  
      
        user.contact.able_for_contact = false        
        flash[:in_from_db_succes] = 'Вы удалились из базы и больше не можете видеть анкеты других участников.'        
      end  
      
      
      if user.contact.save
      
      else   # unless user.save
      
        flash[:res] = 'Попробуйте ещё раз'
      
      end   # if user.save

#______________________________________

    
      # REDIRECT TO CURRENT URL after def handling
    
      cur_url_details_full  = details_full.partition('__').last
    
    
      cur_url_root_64       = cur_url_details_full.partition('_').first    
    
      cur_url_root          = case cur_url_root_64
      when 'ro'
        'room/'
      when 'roo'
        'room_see/'        
      when 're'
        'recommends/'        
      #when 're'
      #  'recommendations/'                
      when 'co'
        'contacts/'
      when 'con'
        'conversations/'                        
      when 'req'
        'requests/'                                
      end    
    
    
      cur_url_details  = cur_url_details_full.partition('_').last
    
      cur_url          = root_path + cur_url_root + cur_url_details
    
#______________________________________      


      redirect_to cur_url

    
    else   # unless order and order.akey == order_akey    

#_______________________________________

    
      redirect_to root_path + 'info/' + 'dannue_receive_obrabotanu'  
      
    end   # unless user and ..

    
  end

#_______________________________________________________________________________



  private  
  
    def set_root
      root_path   = MeConstant.find_by_title('root_path').content    
    end  
  
    def set_info
      @site_title = MeConstant.find_by_title('site_title').content
      @main_page  = MainPage.find(1)   
      
      @page       = Page.find_by_page :room_one
    end          

  
    def user_params
      params.require(:user).permit(:id_in_base, :email, :name, :surname, :group, :akey, :active, :white_writing_able_users_ids_list)
    end  

    
end
