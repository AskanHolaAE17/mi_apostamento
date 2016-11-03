class UsersController < ApplicationController



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
    
    
    order.save
    contact.save    
    
    
      user                 = User.new
      room                 = Room.new     
      
        user.save
        room.save
    
      user.id_in_base    = user.id.to_s + id_in_base(3)
      room.id_in_base    = room.id.to_s + id_in_base(3)          
      
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


  def create
  end

  private  
    def user_params
      params.require(:user).permit(:id_in_base, :email, :name, :surname, :group, :akey, :active, :white_writing_able_users_ids_list)
    end  

    
end
