# encoding: utf-8
class ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session
  helper_method :akey, :repl_all_subs, :swap_symb, :id_in_base, :xor_with, :room_url_def, :navigation_menu_room
  
      
  def akey(*m)
    #key_int = 3.times.map{rand(1..99)}
    #key_str = 3.times.map{('a'..'z').to_a[rand(26)]}
    #key_int.concat(key_str)
    #key_int.shuffle!
    #key_int.shuffle!    
    #key_int.join  
        
	  m = m[0] ? m[0] : false 
	  n = m || 2 
	  time = Time.now.sec
	
  	key_secret = if time % 2 == 0
	      n.times.map{rand(1..99)}
      else
        n.times.map{('a'..'z').to_a[rand(26)]}	
      end	
	
	
    key_int = n.times.map{rand(1..99)}
    key_str_low = n.times.map{('a'..'z').to_a[rand(26)]}
    key_str_up = n.times.map{('A'..'Z').to_a[rand(26)]}
    key_int.concat(key_str_low)
    key_int.concat(key_str_up)
    key_int.shuffle!
    key_int.shuffle!    
    
    key_int.concat(key_secret)
    key_int.shuffle!    
      
    
    len = key_int.length
    
    ins_pos = if time % 3 == 0
      len/2 	
    elsif time % 2 == 0
      len-3
    else
      len/3	
    end	
    
    key_int.insert(ins_pos, '_')
    key_int.join
  end   
  
#_______________________________________________________________________________

  
  def id_in_base(devided_by)    # without Id in begin of string
    iibase = akey + akey          #id_in_base
    iibase = iibase.gsub(/\D+/, '')
    iibase = iibase.slice(0, iibase.length/devided_by.to_i)  
    iibase = iibase.to_s
  end    


  def id_in_base_with_id(devided_by, id)    # without Id in begin of string
    iibase = akey + akey          #id_in_base
    iibase = iibase.gsub(/\D+/, '')
    iibase = iibase.slice(0, iibase.length*2/devided_by.to_i)  
    iibase = id.to_s + iibase.to_s
    
    
    iibase_len = iibase.length
    iibase     = if iibase_len < 8
    
      for i in iibase_len-1..7
        iibase[i] = rand(0..9).to_s
      end
      iibase
    
    elsif iibase_len > 8

      iibase[0..7]
    
    end
    
    iibase
  end    

#_______________________________________________________________________________


  def full_encode_array_to_link_details(array, *use_three_deviders)
    
    #def: true
    use_three_deviders = use_three_deviders[0].nil? ? true : use_three_deviders[0]
    
#________________________________________


    #if use_three_deviders ### add 2 more deviders '_' (before and after center)
    #end
    
#________________________________________

    
    res_string = ''
        
    array.each do |el|
      res_string += el.to_s      
      sec         = Time.now.sec
      res_string += if sec % 2 == 0
        ('a'..'z').to_a.shuffle.first + ('A'..'Z').to_a.shuffle.first
      elsif sec % 5 == 0
        ('A'..'Z').to_a.shuffle.first + ('a'..'z').to_a.shuffle.first
      elsif sec % 3 == 0  
        ('A'..'Z').to_a.shuffle.first      
      else
        ('a'..'z').to_a.shuffle.first
      end
    end
    
    
    res_string_64 = (Base64.encode64 res_string).chomp.delete("\n")
    res_string_64                                
      
  end

#_______________________________________________________________________________
  

  def details_from_url_to_array(details, *is_three_deviders)
  
	  #is_three_deviders = is_three_deviders[0] ? is_three_deviders[0] : false 
	  #is_three_deviders = is_three_deviders || true
	  
    is_three_deviders = is_three_deviders[0].nil? ? true : is_three_deviders[0]	  

#________________________________________    

  
    details[details.length] = 'A'
    res_array = []

#________________________________________    

    
    array_last_element = ''

    for i in 0..details.length-1
      if details[i] == '&'
        @ampersand_position = i
        for m in i+1..details.length-1
          array_last_element += details[m]
        end  
      end
    end
        
        
    details = details[0,@ampersand_position] if @ampersand_position
    
#________________________________________    
    
    
  if is_three_deviders  
    @room_details_res     = ''
    @devider_pos_counter  = 0
    
    #remote all '_' but central
    details.split('').each do |a|  
    
      if a == '_'
        @devider_pos_counter += 1
        
        unless @devider_pos_counter == 2
          next
        end
        
      end  
      
      @room_details_res  += a
    end 
      
    details               =  @room_details_res.to_s 
  end
        
#________________________________________    


    # START EXTRACTING ELEMENTS before '&' for Res_Array 
    @current_i = 0  # common counter of position

#_______________________________________    


    element = ''  # getting element for Res_Array
    
    for i in 0..details.length-1
    
      unless details[i].in? ('a'..'z') or details[i].in? ('A'..'Z') or details[i] == '_'      
      
        element += details[i]
        @current_i += 1
        
      else #skip alphabet symbols
      
        unless element == ''
          res_array    << element.to_i 
          element      = ''
        end  
        
        @current_i     += 1
      end            
          
    end      
    
#________________________________________    
    
    
    if array_last_element != ''
      res_array          << array_last_element
    end

    details[details.length-1] = ''
    
    res_array_last = res_array.last.to_s
    res_array_last[res_array_last.length - 1] = ''
    res_array[res_array.length - 1]


    res_array
  end  
  
#_______________________________________________________________________________  
  
  
  def repl_all_subs(a, b, str)
    count = str.count(a)    
    count.times do
      str = str.sub(a,b)    
    end   
    str
  end  
  
  
  def swap_symb(a, b, str)
    for i in 0..str.length-1
      str[i] = a if str[i] == b
      str[i] = b if str[i] == a
    end
    #str = str.encode('US-ASCII')
    str
  end      
  
#_______________________________________________________________________________    


  def room_url_def(user_id)  
  
    root_path  = MeConstant.find_by_title('root_path').content

#______________________________________    


    user = User.find(user_id)
    room = user.room
    
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
                                 
      room_url                                 
  
  end

#_______________________________________________________________________________
  
  
  def navigation_menu_room(user, root)

     
    # NAVIGATION MENU - ROOM
    # REQUESTS
    
    req_link_id      = user.id.to_s
    
    req_code         = user.id_in_base.to_s   # requests_link_id_in_base
    req_code_len     = req_code.length
    req_link_code    = req_code[req_code_len-3..req_code_len-1]    
    
    req_link_id_len  = req_link_id.length.to_s    
    
    
    requests_link_details        = req_link_code + req_link_id + req_link_id_len
    requests_link_details_64     = (Base64.encode64 requests_link_details).delete("\n").delete('=')
    
    @nav_menu_room_requests_link = root_path + 'requests/' + requests_link_details_64
    @requests_menu_title         = 'Запросы на общение - полученные и отправленные'
    
#______________________________________


    # NAVIGATION MENU - ROOM
    # CONVERSATIONS    
    
    conv_link_id      = user.id.to_s
    
    conv_code         = user.id_in_base.to_s   # requests_link_id_in_base
    conv_code_len     = conv_code.length
    conv_link_code    = conv_code[conv_code_len-3..conv_code_len-1]    
    
    conv_link_id_len  = conv_link_id.length.to_s    
    
    
    convs_link_details          = conv_link_code + conv_link_id + conv_link_id_len
    convs_link_details_64       = (Base64.encode64 convs_link_details).delete("\n").delete('=')
    
    @nav_menu_room_convers_link = root_path + 'conversations/' + convs_link_details_64
    @convers_menu_title         = 'По переписке'

#______________________________________


    # NAVIGATION MENU - ROOM
    # SHOW/OFF IN BASE 
    
    user_off_db_id_len         = user.id.to_s.length.to_s
      
    user_off_db_id_in_base_len = user.id_in_base.length
    user_off_db_code           = user.id_in_base[user_off_db_id_in_base_len-4..user_off_db_id_in_base_len-2]
      
      
    show_off_db_details_64     = user.id.to_s + user_off_db_code + user_off_db_id_len
    show_off_db_details        = (Base64.encode64 show_off_db_details_64).delete("\n").delete('=')
          
#______________________________________

    
    if user.contact.able_for_contact
    
      # OFF
      # off show                  
    
      off_db_link_now         = root_path    + 'in_from_base/' + 'f' + show_off_db_details
      
      @show_off_in_base_menu_name  = 'Удалиться'
      @show_off_in_base_menu_title = 'Удалиться из базы (другие пользователи не будут Вас видеть)'

#__________________________________________    

    
    else


      # SHOW
      #      
      
      # just if ALREADY in DB
      if user.contact.order.more_info_save      
    
        show_db_link = root_path + 'in_from_base/' + 'i' + show_off_db_details        
        
        @show_off_in_base_menu_name = 'Добавиться'
        @show_off_in_base_menu_title = 'Добавиться в базу (другие пользователи смогут Вас видеть)'
            
#__________________________________________    

      
      else   # unless user.contact.order.more_form_save

        order_db = user.contact.order
        
        # open MORE INFO FORM
        show_db_form_redirect_letter  = ('a'..'z').to_a.shuffle.first
        show_db_form_link_details     = order_db.id.to_s               + 
                                        show_db_form_redirect_letter   + 
                                        order_db.akey_payed

#____________________


        show_db_form_link_details_encoded_64  = (Base64.encode64 show_db_form_link_details).chomp.delete("\n")  
    
#____________________


        @show_off_in_base_menu_name = 'Добавиться'
        @show_off_in_base_menu_title = 'Добавиться в базу (другие пользователи смогут Вас видеть)'
              
        off_db_link_form         = root_path + 'much_form/' + show_db_form_link_details_encoded_64 + '__t'          
        
      end   # if user.contact.order.more_form_save
              
          
    end
    

    @nav_menu_room_show_off_in_base_link = if off_db_link_form
    
      off_db_link_form      
    else  
    
      (show_db_link || off_db_link_now) + '__' + root + '_' + params[:details]   
    end
      
    
    # ro - Room

#______________________________________


    # NAVIGATION MENU - ROOM
    # CONTACTS
    
    # just if user SHOW in DB        
        
    if user.contact.able_for_contact
    
    
      contacts_status = if user.contact.order == 'GOOD GROUP'                     
        [2,4,6,8].shuffle.first.to_s
      else
        [1,3,5,7,9].shuffle.first.to_s      
      end

#____________________


      plus_2_letters      = ('a'..'z').to_a.shuffle.first + 
                            ('a'..'z').to_a.shuffle.first
           
      contacts_details    = contacts_status               + 
                            user.contact.order.id.to_s    + 
                            plus_2_letters                + 
                            user.contact.order.akey_payed                     


#____________________


      contacts_details         = (Base64.encode64 contacts_details).chomp.delete("\n").delete('=')


      @nav_menu_contacts_link  =  root_path               + 
                                 'contacts/'              + 
                                  contacts_details    
                                  
      @contacts_menu_title     = 'Анкеты других участников сайта'      
    
      
    end       

#______________________________________


    # NAVIGATION MENU - ROOM
    # CONSULTS
        

#______________________________________    


    # NAVIGATION MENU - ROOM ONE
    # ROOM ONE (Room of current User)
        
        
    @nav_menu_room_one_link = room_url_def(user.id)
    @room_one_menu_title    = 'Ваши комната с новостями и событиями'    

#___________________________________________________________


    # RECOMMENDATIONS +in NAVIGATION MENU - ROOM
   
    user_id_in_base       = user.id_in_base.to_s
    user_iib_last         = user_id_in_base.length - 1
    user_code             = user_id_in_base[user_iib_last - 1] + user_id_in_base[user_iib_last]
    
    feed_al_arr           =  feedback_sl_array = []    
    feed_al_arr << user.id
    feed_al_arr << ('a'..'z').to_a.shuffle.first
    feed_al_arr << user_code

    details               = full_encode_array_to_link_details(feed_al_arr, false)
    @link_to_feedbacks_sl = root_path + 'recommendations/' + details   #  Structure Level
    
    
    @recommendations_menu_title = 'Для Вас и Вашего партнера'

#______________________________________    

    
    # TO THE TOP - BUTTON

    @to_the_top_button_link  = '#top' 
    @to_the_top_button_title = 'Вернуться в начало страницы'
    
#______________________________________    
    
  
  end    
  
#_______________________________________________________________________________  


end
