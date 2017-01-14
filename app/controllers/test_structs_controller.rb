require 'uri'
require 'openssl'
class TestStructsController < ApplicationController


  before_action :set_root,      only: [:struct_qws_signal, :struct_qws_body,  :struct_qws_signal_more, :form_gender_if_il_struct]
  before_action :set_info,      only: [:struct_qws_signal, :struct_qws_body,  :struct_qws_signal_more, :form_gender_if_il_struct]  
#_____________________________________________________________________________________________________________________________________________


  def struct_qws_signal

    test_url_encoded = params[:test_encrypted].partition('#').first                 
    test_url_json    = Base64.decode64(test_url_encoded)    
    test_url_hash    = JSON.parse(test_url_json)
    
    order_id         = test_url_hash['oi'].to_i    
    order_akey       = test_url_hash['oa']            
    
#______________________________________
    
    
    order            = Order.find(order_id)
    
#______________________________________

  
    if order and order.akey[0..2] == order_akey             
    
  
      if order.current_test_link == '' or order.current_test_link == nil 
      
        order.current_test_link = 'testo_s/' + test_url_encoded          
        
      #else
      #  if order.current_test_link != 'testo_s/' + test_url_encoded
      #    redirect_to root_path + order.current_test_link	
      #  end  
      end   # unless order.current_test_link == '' or order.current_test_link == nil                     

#______________________________________


      @qw_struct_signals = QwStructSignal.all
      @order = order
        
#______________________________________
        
  
    ## 0 t  - test
    ## 1 q  - question
    ## 2 oi - order id
    ## 3 oa - order akey
    ## 4 ps - ps
    ## 5 po - po
    ## 6 ne - ne
    
    #test_url_uncoded = "

    #  t2',
    #  :q  => #{@order.current_qw_struct or '1'},
    #  :oi => @order.id,
    #  :oa => @order.akey,
    #  :ps => '0',
    #  :po => '0',
    #  :ne => '0'                  
      
    #".delete("\n").delete(' ')

    #test_url_64       = Base64.encode64 test_url_uncoded
    #test_url_details  = test_url_64.chomp.delete("\n").delete('=')
    #test_url          = root_path + 'tests/' + test_url_details
    #or
    #test_url          = root_path + test_url_details    

#______________________________________

      order.save
              
    else   # unless order and order.akey == order_akey    
    
      #security_of_mailing = SecurityOfMailing.new
      #SecureMailer.wrong_url().deliver
      
      redirect_to '/'
      
    end   # if order and order.akey == order_akey    
  end  
  
  
#_____________________________________________________________________________________________________________________________________________


  def signal_struct_array_save
    
    order_id   = params[:order_id]
    order_akey = params[:order_akey_start]
    
    order = Order.find(order_id)
    
#______________________________________

  
    if order and order.akey[0..2] == order_akey           
    
      signal_struct_arr            =  params[:order_signal_struct_array] || []

#_______________________________________

      
      if signal_struct_arr.count.in? 2..4

        
        current_struct             =  signal_struct_arr[0]                

#_______________________________________

        
        signal_struct_arr          =  signal_struct_arr.join(' ')
        order.signal_struct_arr    =  signal_struct_arr
        
        order.signal_struct_done   =  true
        order.save
        
#_______________________________________

          
        if 'il'.in? params[:order_signal_struct_array] 
                  
          #order.save
          #flash[:struct] = order.struct
          
          
          gender_rand_digit     = rand(0..9).to_s
          
          gender_details        = gender_rand_digit +
                                  order.id.to_s     +
                                  ' '               +
                                  order.akey[0..2] 
                                               
          gender_details_url    = Base64.encode64(gender_details).delete("\n").delete('=')
          
          
          redirect_to root_path + 'tests_gender/' + gender_details_url
          
#_______________________________________
          
                             
        else   # unless order.struct == 'il'
                    

        #QUESTIONS
        test           =  Test.find_by         number_of_test: 1
        questions_all  =  test.questions
        questions_on   =  questions_all.where  able: true          
        questions      =  questions_on.where   for_yes_answer_plus_1_point_to: current_struct

#_______________________________________


        # PARAMS with QWS NUMBERS
        # cur_user_qws
        # cuq_ 
        
        cuq_signal_structs         = order.signal_struct_arr.split(' ')
        
        
        cuq_all_qws_numbers_array  = []                
        
        cuq_signal_structs.each do |struct|
          cuq_all_cur_user_qws     = questions_on.where for_yes_answer_plus_1_point_to: struct
          
          cuq_all_cur_user_qws.each do |cuq|
            cuq_all_qws_numbers_array << cuq.number_of_question.to_s
          end 
        end  
        
        
        cuq_all_qws_numbers_shuffle    = cuq_all_qws_numbers_array.shuffle
        cuq_all_qws_numbers_params     = cuq_all_qws_numbers_shuffle.join(' ')
        
        cuq_all_qws_numbers_params    += ' ' + rand(0..9).to_s + rand(0..9).to_s
        cuq_all_qws_numbers_params_64  = (Base64.encode64 cuq_all_qws_numbers_params).delete("\n").delete('=')

#_______________________________________
        
              
        #QUESTION
          
        question       =  questions.first
        qw_number      =  cuq_all_qws_numbers_shuffle.first
        #qw_number      =  question.number_of_question        
 
     
        test_url_hash  =  {
  
          t:     '1',
          q:     qw_number,
          oi:    order.id,
          oa:    order.akey[0..2],
            
          a:     '0',
          n:     '0',
          s:     '0',
          p:     '0',
          g:     '0',
          d:     '0',
          m:     '0',
          o:     '0',
          k:     '0',
          i:     '0',                            
            
          cur_s: current_struct
          }        
        
        test_url_json    = JSON.generate(test_url_hash)        
        test_url_encoded_64 = (Base64.encode64 test_url_json).chomp.delete("\n").delete('=')        
        test_url = root_path + 'tests_s/' + test_url_encoded_64 
        
#_______________________________________


        test_url_qws = test_url + '?qs=' + cuq_all_qws_numbers_params_64

        redirect_to  test_url_qws 
          
#_______________________________________          


        end   # if order.struct == 'il'

      else   # signal_struct_arr.count NOT in? 1..3
        
                
        flash[:error_class_signal_struct_arr]                = 'error_field'           
        #anchor = '#1'
        anchor = ''
        
#_______________________________________


      if signal_struct_arr
        sqw = signal_struct_arr.to_s
        sqw.gsub!('"',"'")
        sqw.gsub!('[',"")
        sqw.gsub!(']',"")
        sqw.gsub!("'","")      
        sqw.gsub!(" ","")                       
        #signal_struct_arr = sqw
      #end                     
      
      #if sqw
        sqw = sqw.split(",")         
        sqw.each  do |sqw|
	        flash['signal_struct_arr_' + sqw.to_s]   = 'checked' 	      
        end	 
      end           
        
#_______________________________________

        
        test_url_hash = {
          oi: order.id,
          oa: order.akey[0..2]
        }        
        
        test_url_json    = JSON.generate(test_url_hash)        
        test_url_encoded_64 = (Base64.encode64 test_url_json).chomp.delete("\n").delete('=')        
        test_url = root_path + 'testo_s/' + test_url_encoded_64
        
        
        redirect_to test_url + anchor

      end   # signal_struct_arr.checkbox_has_1_3values            
        
    else   # unless order and order.akey == order_akey    

#_______________________________________

    
      #security_of_mailing = SecurityOfMailing.new
      #SecureMailer.wrong_url().deliver
      redirect_to root_path + 'info/' + 'dannue_receive_obrabotanu'  
    end   # signal_struct_arr.count.in? 1..3
    
  end

#_____________________________________________________________________________________________________________________________________________


  #def load_want_to_db_after_test_struct(order, order_id, order_akey)
  #def load_want_to_db_after_test_struct(order, good_arr, bad_arr)
  
  def load_want_to_db_after_test_struct(order)
  
          
        if order.group == 'GOOD GROUP'
           order.group = 'BAD GROUP'   if order.struct.in? ['al',  'nl', 'shl', 'pl', 'gml']    
           #order.group = 'GOOD GROUP'  if order.struct.in? ['dl', 'ml',  'ol', 'kl', 'il']                        
        end  

#_______________________________________            
       
        
        #order.group = if good_arr.max > bad_arr.max         
        #  'GOOD GROUP'                     
        #else                   
        #  'BAD GROUP'       
        #end

#_______#________________________________


        #if order.group == 'GOOD GROUP'
        
        #  order.struct = case good_arr.index(good_arr.max)
        #  when 0
        #    'dl'
        #  when 1
        #    'ml'
        #  when 2
        #    'ol'
        #  when 3
        #    'pl'
        #  when 4
        #    'kl'
        #  when 5
        #    'il'
        #  end        
          
        #else   # UNLESS order.group == 'GOOD GROUP'

        #  order.struct = case bad_arr.index(bad_arr.max)
        #  when 0
        #    'al'
        #  when 1
        #    'nl'
        #  when 2
        #    'shl'
        #  when 3
        #    'gml'            
        #  end
                  
        #end   # IF order.group == 'GOOD GROUP'

#_______________________________________


        struct = order.struct
          
#_______________________________________
        

      #    current_qw_struct_i = order.current_qw_struct.to_i
          
      #    if current_qw_struct_i == 0
      #      cur_struct_qw        = ((Question.where test: 1).where number_of_question: 1).first          
      #    end      
          
      #    if current_qw_struct_i != 0
      #      cur_struct_qw        = ((Question.where test: 1).where number_of_question: order.current_qw_struct).first          
      #    end      
                    
      #    cur_struct             = cur_struct_qw.for_yes_answer_plus_1_point_to
            
      #    test_1_start_url_hash  =  {
        
      #      #?st:     struct, #?
      #      t:      '1',
      #      q:      "#{order.current_qw_struct or '1'}",        
      #      oi:     order_id,
      #      oa:     order_akey,
      #      cur_s:  cur_struct,          
          
      #      a:      '0',
      #      n:      '0',
      #      s:      '0',
      #      p:      '0',
      #      g:      '0',
      #      d:      '0',
      #      m:      '0',
      #      o:      '0',
      #      k:      '0',
      #      i:      '0'
      #    }        

#_______________________________________


      #    test_1_start_url_json     = JSON.generate(test_1_start_url_hash)
      #    test_1_start_url_encoded  = (Base64.encode64 test_1_start_url_json).chomp.delete("\n").delete('=')
        
      #    test_1_start_url          =  root_path                + 
      #                              'infos/'                  + 
      #                             'tekst_mezhdy_testami/'   + 
      #                               test_1_start_url_encoded                                            

#__________________________________________


      # Creation of LINK: do_you_want_to_db 
      
      root_path   = MeConstant.find_by_title('root_path').content    
      
      order_id_for_do_you_want_to_db  = order.id.to_s
      oi_want_todb                    = order_id_for_do_you_want_to_db
      
      oi_want_todb                    = oi_want_todb.insert(oi_want_todb.length-1, (0..9).to_a.shuffle.first.to_s)
      order_id_for_do_you_want_to_db  = oi_want_todb                
      
      do_you_want_to_db_link          = root_path + 'do_you_want_to_db/' + order_id_for_do_you_want_to_db
      
#__________________________________________

      
      #OrderMailer.bx_2_events_do_you_want_to_db(order, do_you_want_to_db_link).try(:deliver)   # LINK: do_you_want_to_db 
                   
#__________________________________________
      

      ## Creation of LINK: more_info_form
      #redirect_letter          = ('a'..'z').to_a.shuffle.first
      #link_details             = order.id.to_s               + 
      #                           redirect_letter             + 
      #                           order.akey_payed
      #link_details_encoded_64  = (Base64.encode64 link_details).chomp.delete("\n").delete('=')

      
      #link_with_more_info_form = root_path + 'much_form/' + link_details_encoded_64                            
      
#__________________________________________


      #plus_2_letters           = ('a'..'z').to_a.shuffle.first + 
      #                           ('A'..'Z').to_a.shuffle.first
                                                                                                   
      
      #details                  = order.id.to_s                 + 
      #                           plus_2_letters                + 
      #                           '&'                           +
      #                           order.akey_payed[0,3]                
                                 
                                 
      #details  = (Base64.encode64 details).chomp.delete("\n").delete('=')                                 
      
      
      #link_with_contacts_again = root_path                     + 
      #                          'show-contacts/'               + 
      #                           details                       
      
#__________________________________________
      
      
      #unless order.test_1_ended
      #  OrderMailer.c_more_info_form(order, link_with_more_info_form, link_with_contacts_again).try(:deliver)      
      #end              
            
#__________________________________________      

     
      #order.test_1_ended     = true      
      order.akey         = ''
          
      order.current_qw_struct = ''
     
#__________________________________________      

        
      order.save
      
      redirect_to     do_you_want_to_db_link
      
  end   # def load_want_to_db_after_test_struct(order, order_id, order_akey)
  
#_____________________________________________________________________________________________________________________________________________

  
  def struct_qws_body

          # ['c'] ------controller   # no
          # ['an']------action name  # no
                      
          # ['t']       test_number
          # ['q']       qw_number  
          # ['oi']      order_id   
          # ['oa']      order_akey 
          
          # a, n, s, p, g, d, m, o, k, i
                    
          # ['cur_s']   current_struct (of qws)

#_______________________________________    

  
    test_url_encoded       = params[:test_encrypted]                 

    back_button_show_flag  = test_url_encoded.partition('__').last
    test_url_encoded       = test_url_encoded.partition('__').first
    
    test_url_json     = Base64.decode64(test_url_encoded)    
    test_url_hash     = JSON.parse(test_url_json)
    
#_______________________________________    

        
    order_id    = test_url_hash['oi']
    order_akey  = test_url_hash['oa']

#_______________________________________

        
    order = Order.find(order_id)                    
    
#_______________________________________      

      
    #if order.test_1_ended                                  # if Test2 has ended previously
    #  redirect_to root_path + 'info/test_yzhe_proyden'       # Redirect immediately to explaining Msg
    #end        
    
#_______________________________________


    if order and order.akey[0..2] == order_akey

#_______________________________________    

        
      qw_number      = test_url_hash['q'].to_i             
    
#_______________________________________

    
      test_url_encoded = 'tests_s/' + test_url_encoded    
      
#_______________________________________


      cur_answs = current_answers_hash = test_url_hash            
      
      last_answers_encoded          = order.current_test_link.partition('/').last   # just text after '/'
      last_answers_json             = Base64.decode64 last_answers_encoded    
      
      if order.current_test_link.partition('/').first == 'tests_s'
        last_a = last_answers_hash    = JSON.parse last_answers_json       
      else  
        last_a = 'a'
      end  
      
      cur_a  = cur_answs            # cur_answs  = current_answers_hash = test_url_hash
               
#____________________

      
      if order.current_test_link.partition('/').first == 'tests_s' and
         last_a['q'].to_i != cur_a['q'].to_i                       and
         back_button_show_flag != 'f' 
            
        @back_qw_button = root_path + order.current_test_link + '__f'   # back to PrewQw
      end        
    
#____________________
              
      
      #if (  order.current_test_link == ''  or  order.current_test_link == nil  and
      if  order.current_test_link                      and  
          order.current_test_link != test_url_encoded  and  
          last_a['t']     == cur_a['t']                and
          last_a['cur_s'] >  cur_a['cur_s']            and          
          last_a['q'].to_i     >  cur_a['q'].to_i      and 3==5
           
            
        #if  last_a["t"]   == cur_a["t"]               
          redirect_to root_path + order.current_test_link
        
        else   #  unless  order.current_test_link  and  last_a["t"]   == cur_a["t"]   
               ## unless last_a["t"]   == cur_a["t"]                       
        
        ##end   # if  last_a["t"]   == cur_a["t"]       
          
      #end   # if  order.current_test_link  and  last_a["t"]   == cur_a["t"]  

#_______________________________________

      
      #if qw_number.to_i == 1
            
      #  if order.current_test_link and cur_answs   # going to REDIRECT to cur test PROGRESS PAGE
                                                   
      #    if order.current_qw_struct
      
      
      #      cur_test_link_encoded            = order.current_test_link.partition('/').last   # just text after '/'
      #      cur_test_link_json               = Base64.decode64(cur_test_link_encoded)    
        
      #      cur_link  = cur_test_link_hash   = JSON.parse(cur_test_link_json)        
          
          
      #      if cur_link['q'].to_i != cur_answs['q'].to_i
            
              #order.save
      #        redirect_to root_path + order.current_test_link              
      #      end
        
      #    end   # if order.current_qw_struct  
      #  end   # if order.current_test_link
      #end   # if qw_number.to_i == 1      
  
#_______________________________________


      #current_test_link  =  order.current_test_link
      
      #order.current_test_link = test_url_encoded        
      
#_______________________________________      

 
      #SET CURRENT STRUCT OF QWS
      current_struct    =  test_url_hash['cur_s']   # current struct (of qws)    
    
#_______________________________________

      
      #QUESTIONS
      test             =  Test.find_by              number_of_test: 1
      questions_all    =  test.questions
      questions_on     =  questions_all.where       able: true                
      #questions
      #.limit(1)          
            
#_______________________________________


        # PARAMS with QWS NUMBERS
        # cur_user_qws
        # cuq_ 
        
        cuq_signal_structs         = order.signal_struct_arr.split(' ')
        
        
        cuq_all_qws_numbers_array  = []                
        
        cuq_signal_structs.each do |struct|
          cuq_all_cur_user_qws     = questions_on.where for_yes_answer_plus_1_point_to: struct
          
          cuq_all_cur_user_qws.each do |cuq|
            cuq_all_qws_numbers_array << cuq.number_of_question.to_s
          end 
        end  
        
        cuq_all_qws_numbers_params     = cuq_all_qws_numbers_array.join(' ')
        cuq_all_qws_numbers_params    += ' ' + rand(0..9).to_s + rand(0..9).to_s
        cuq_all_qws_numbers_params_64  = (Base64.encode64 cuq_all_qws_numbers_params).delete("\n").delete('=')

#_______________________________________


        ##
        #current_struct
        
        params_qs_64     = params[:qs]
        params_qs_full   = Base64.decode64 params_qs_64
        
        params_qs_full_ar          = params_qs_full[0..params_qs_full.length-4].split(' ')
        params_qs_full_ar_in_order = params_qs_full_ar.sort
        
        cuq_all_qws_numbers_params_ar          = cuq_all_qws_numbers_params[0..cuq_all_qws_numbers_params.length-4].split(' ')
        cuq_all_qws_numbers_params_ar_in_order = cuq_all_qws_numbers_params_ar.sort	
        
        unless params_qs_full_ar_in_order == cuq_all_qws_numbers_params_ar_in_order
          redirect_to '/'
        end
        
        params_qs        = params_qs_full[0..params_qs_full.length-4]
        all_cur_user_qws = params_qs.split(' ')                           
        @all_cur_user_qws = params_qs_full_ar
    
#_______________________________________      


      @back_qw_button = @back_qw_button + '?qs=' + params_qs_64   if @back_qw_button

#_______________________________________      

    
      #QUESTION
      question         =  questions_all.find_by     number_of_question: qw_number                 
    
#_______________________________________      


      #DEFINE NO count
      al_no   = test_url_hash['a']
      nl_no   = test_url_hash['n']
      shl_no  = test_url_hash['s']
      pl_no   = test_url_hash['p']
      gml_no  = test_url_hash['g']
      dl_no   = test_url_hash['d']
      ml_no   = test_url_hash['m']
      ol_no   = test_url_hash['o']
      kl_no   = test_url_hash['k']
      il_no   = test_url_hash['i']
    
#_______________________________________
        
        
        unless order.current_test_link == '' or order.current_test_link == nil
    
          if  last_a['t']   == cur_a['t'] 
                              
                
              if  (  last_a['a'].to_i   ==  cur_a['a'].to_i  and
                     last_a['n'].to_i   ==  cur_a['n'].to_i  and
                     last_a['s'].to_i   ==  cur_a['s'].to_i  and
                     last_a['p'].to_i   ==  cur_a['p'].to_i  and
                     
                     last_a['g'].to_i   ==  cur_a['g'].to_i  and
                     last_a['d'].to_i   ==  cur_a['d'].to_i  and
                     last_a['m'].to_i   ==  cur_a['m'].to_i  and
                     last_a['o'].to_i   ==  cur_a['o'].to_i  and
                     last_a['k'].to_i   ==  cur_a['k'].to_i  and
                     last_a['i'].to_i   ==  cur_a['i'].to_i  and
                                                                                                                                                                                           
                     order.yes_qws_struct[-2] != '|'  )                    
              
              
                                 
                yes_qws_struct       =  order.yes_qws_struct.split(' ')                                 
                yes_qws_struct.pop   
                            
                order.yes_qws_struct = yes_qws_struct.join(' ')
                order.save                

#_______________________________________              


              elsif back_button_show_flag == 'f'              
              
                yes_qws_struct       =  order.yes_qws_struct.split(' ')                                 
                
                yes_qws_struct.pop   
                yes_qws_struct.pop   

                
                order.yes_qws_struct = yes_qws_struct.join(' ')              

              end   # if YES wasn`t addes (on prew page)
            
      
          end   # if last_a["t"] == cur_a["t"]
         
        end   # unless order.current_test_link == '' or order.current_test_link == nil    
        
#_______________________________________              

                                                                                                            
      #if  question  and  (qw_number < questions.count + 1) and next_question    #----- Start TestShow Part
      
      if  question   #----- Start TestShow Part                  

        
        if order.gender 
        
          if order.gender == 'Ж'
            @she_gender = true
            #@he_gender  = false
          end
          
          if order.gender == 'М'
            #@she_gender = false
            @he_gender  = true
          end
                    
        end

        order.yes_qws_struct << ' ' << qw_number.to_s << question.for_yes_answer_plus_1_point_to[0] << '.'   # save cur qw_number to YES order array                 

#_______________________________________      


        order.current_test_link = test_url_encoded

#_______________________________________      
    
    
        ##~NEXT QUESTION (if exist)
        #questions_cur_s  =  questions_on.where       for_yes_answer_plus_1_point_to: current_struct
          
        #cur_qw_index     =  questions_cur_s.index(question)
        
                        
        #next_qw_index    =  cur_qw_index + 1
        #next_question    =  questions_cur_s[next_qw_index]
          
        #if next_question
        
        #  next_qw_number =  next_question.number_of_question    
          
        #else 
        
        #  signal_struct_arr     =  order.signal_struct_arr.split(' ')       # get array of EXIST STRUCTS
        #  current_s_index      =  signal_struct_arr.index(current_struct)   # index of CURRENT STRUCT in array
        #  next_struct          =  signal_struct_arr[current_s_index + 1]   # get NEXT struct
        
        #  questions_new_cur_s  =  questions_on.where  for_yes_answer_plus_1_point_to: next_struct   # get QWS with this struct
          
                            
        #  if questions_new_cur_s[0]   # if there are qws with THIS STRUCT
        
        #    next_question      =  questions_new_cur_s[0]             # get next QW (if there are qws with THIS STRUCT)
        #    next_qw_number     =  next_question.number_of_question   # get next QW number (for hash)            
          
        #    current_struct     =  next_struct   # for cur_s in HASH
        #  else
          
        #    next_qw_number     = Question.all.count + 1  # set UNDER LIMIT number of NEXT QW (for test will ended)
        #  end              
           
        #end  
        
#_______________________________________

        
        next_qw_index   = @all_cur_user_qws.index(qw_number.to_s) + 1
        
        next_qw_number = if @all_cur_user_qws[next_qw_index]        
          @all_cur_user_qws[next_qw_index].to_s
        else
          (Question.count + 1).to_s
        end

#_______________________________________

      
        @question      =  question          
        
        @qw_number     =  qw_number        
            
#_______________________________________


        order.current_qw_struct = qw_number.to_s
          
#_______________________________________


        #NO HASH
        no_params_hash = {
          t:    '1',
          q:    next_qw_number,
          oi:   order_id,
          oa:   order_akey[0..2],
          a:   "#{al_no or '0'}",  
          n:   "#{nl_no or '0'}",  
          s:   "#{shl_no or '0'}",  
          p:   "#{pl_no or '0'}",            
          g:   "#{gml_no or '0'}", 
           
          d:   "#{dl_no or '0'}",  
          m:   "#{ml_no or '0'}",  
          o:   "#{ol_no or '0'}",  
          k:   "#{kl_no or '0'}",  
          i:   "#{il_no or '0'}",                                                                                  
            
          cur_s: current_struct
        }
            
#_______________________________________      

    
        #NO LINK
        no_params_json     = JSON.generate(no_params_hash)
        no_params_encoded  = (Base64.encode64 no_params_json).chomp.delete("\n").delete('=')
        
        @no_params         =  root_path         + 
                             'tests_s/'         + 
                              no_params_encoded +
                             '?qs='             +
                              params_qs_64
        
#_______________________________________      

        
        if question.able == false
          redirect_to @no_params
        end
                
#_______________________________________      


        #DEFINE YES count
        case       question.for_yes_answer_plus_1_point_to
          when 'al' 
            then   al_yes    = (al_no.to_i + 1).to_s
          when 'nl' 
            then   nl_yes    = (nl_no.to_i + 1).to_s
          when 'shl' 
            then   shl_yes   = (shl_no.to_i + 1).to_s
          when 'pl' 
            then   pl_yes    = (pl_no.to_i + 1).to_s            
          when 'gml' 
            then   gml_yes   = (gml_no.to_i + 1).to_s
            
          when 'dl' 
            then   dl_yes    = (dl_no.to_i + 1).to_s
          when 'ml' 
            then   ml_yes    = (ml_no.to_i + 1).to_s
          when 'ol' 
            then   ol_yes    = (ol_no.to_i + 1).to_s
          when 'kl' 
            then   kl_yes    = (kl_no.to_i + 1).to_s
          when 'il' 
            then   il_yes    = (il_no.to_i + 1).to_s
        end                                  
      
        
        #YES HASH      
        yes_params_hash = {
          t:   '1',
          q:   next_qw_number,
          oi:  order_id,
          oa:  order_akey[0..2],
          
          a:   "#{al_yes  or al_no  or '0'}",
          n:   "#{nl_yes  or nl_no  or '0'}",
          s:   "#{shl_yes or shl_no or '0'}",
          p:   "#{pl_yes  or pl_no  or '0'}",          
          g:   "#{gml_yes or gml_no or '0'}",
          
          d:   "#{dl_yes  or dl_no  or '0'}",
          m:   "#{ml_yes  or ml_no  or '0'}",
          o:   "#{ol_yes  or ol_no  or '0'}",
          k:   "#{kl_yes  or kl_no  or '0'}",
          i:   "#{il_yes  or il_no  or '0'}",                                                                                          
            
          cur_s: current_struct
        }                        

#_______________________________________      


        #YES LINK    
        yes_params_json     = JSON.generate(yes_params_hash)
        yes_params_encoded  = (Base64.encode64 yes_params_json).chomp.delete("\n").delete('=')
    
        @yes_params         =  root_path          + 
                              'tests_s/'          + 
                               yes_params_encoded +
                               '?qs='             +
                               params_qs_64
    
#_______________________________________      
       	     
		    
        #@questions_numbers_for_serial = []
        #signal_struct_arr = order.signal_struct_arr.split(' ')
        
        #signal_struct_arr.each do |sign_st_arr_el|
        #  questions_for_serial = questions_on.where for_yes_answer_plus_1_point_to: sign_st_arr_el
          
        #  questions_for_serial.each do |qw_for_ser|
        #    @questions_numbers_for_serial << qw_for_ser.number_of_question
        #  end
          
        #end
                 

        #@current_question_serial_number = @questions_numbers_for_serial.index(qw_number) + 1   
        #@current_question_serial_number = @current_question_serial_number.to_s	
		    
		    
	all_qws_for_to_do_64 = params[:qs]
	all_qws_for_to_do    = Base64.decode all_qws_for_to_do_64	    
	all_qws_for_to_do_ar = all_qws_for_to_do.split(' ')		            
        @current_question_serial_number	= (all_qws_for_to_do_ar.index(qw_number.to_s) + 1).to_s
		    
        
        @questions_amount = order.signal_struct_arr.split(' ').count * 5
        @questions_amount = @questions_amount.to_s   
		    
      
#_______________________________________            


        order.save

#_______________________________________            


      else   #----- TestShow Part
              #     unlesss question  (TEST was ENDED)

#_______________________________________              


        # count of ДА in every ResultStructGroups
        l_arr = structs_array    = [al_no.to_i, nl_no.to_i, shl_no.to_i, pl_no.to_i, gml_no.to_i, 
                                    dl_no.to_i, ml_no.to_i, ol_no.to_i, kl_no.to_i, il_no.to_i]              
                                            
        
        max_l = max_struct_count = structs_array.max                                         # max count of points

        l_ind = struct_indexes   = l_arr.each_index.select{                                 # Indexes of struct(s) with MaxPoints
                                  |i| l_arr[i] == max_l }        

#_______________________________________            

        
        # if more then 1 StructGroup with MaxPoints        
        if l_ind.count > 1                                                                                 
                                                                  
          max_names = ''      # if same count in diffrent groups - define variable for GroupsNAMES                                   
            
          l_arr.each.with_index do |el, i|                     
            if el == max_l 
              max_names += '0 ' if i == 0
              max_names += '1 ' if i == 1
              max_names += '2 ' if i == 2
              max_names += '3 ' if i == 3
              
              max_names += '4 ' if i == 4
              max_names += '5 ' if i == 5                                          
              max_names += '6 ' if i == 6
              max_names += '7 ' if i == 7
              max_names += '8 ' if i == 8
              max_names += '9'  if i == 9                                                        
            end
          end         
          
          max_names = max_names.split(' ')    


          if al_no.to_i + nl_no.to_i + shl_no.to_i + pl_no.to_i + gml_no.to_i + dl_no.to_i + ml_no.to_i + ol_no.to_i + kl_no.to_i + il_no.to_i == 0

            for i in 0..max_names.length-1
              max_names[i] = '0'
            end
          
          end
      
#_______________________________________        

          
          test_2_signal_more_array    =            
            order_id.to_s             + 
            ' '                       + 
            order_akey[0..2].to_s     +
            ' '                       +            
            max_names[0]              +
            ' '                       +             
            max_names[1]              
                        
          if max_names[2]   
            test_2_signal_more_array += ' ' + max_names[2].to_s
          end
            
          if max_names[3]   
            test_2_signal_more_array += ' ' + max_names[3].to_s
          end
                              

          #test_2_signal_more_json     =  JSON.generate(test_2_signal_more_hash)
          test_2_signal_more_encoded  =  (Base64.encode64 test_2_signal_more_array).chomp.delete("\n").delete('=')        
          
          
          order.current_test_link     = 'tests_more/' + test_2_signal_more_encoded
          
          test_2_signal_more          =  root_path + 
                                         order.current_test_link
          
          
           order.struct_test_info =  order.struct_test_info.to_s   + ' '     +
                                        'Al: '  + al_no  + ' ___ ' +       
                                        'Nl: '  + nl_no  + ' ___ ' +
                                        'Shl: ' + shl_no + ' ___ ' +
                                        'Pl: '  + pl_no  + ' ___ ' +                                        
                                        'Gml: ' + gml_no + ' __---__ '       +  
                                        'Dl: '  + dl_no  + ' ___ ' +
                                        'Ml: '  + ml_no  + ' ___ ' +
                                        'Ol: '  + ol_no  + ' ___ ' +  
                                        'Kl: '  + kl_no  + ' ___ ' +
                                        'il: '  + il_no  + ' '
  
          
          order.save                        
          redirect_to test_2_signal_more   # redirect to struct_qws_signal_more PAGE
          
#_______________________________________        

                
        else                                                                          # if just 1 max StructGroupResult -> define the Group
               # unless l_ind.count > 1                                                                  
               
          # if STRUCT defined SUCCESS          
            #order.struct = l_arr[l_ind[0]]
          
          order.struct = case l_ind[0]   # selected STRUCT (if selected JUST 1)
            when 0
              'al'
            when 1
              'nl'              
            when 2
              'shl'              
            when 3
              'pl'                            
            when 4
              'gml'
              
            when 5
              'dl'
            when 6
              'ml'
            when 7
              'ol'
            when 8
              'kl'
            when 9
              'il'                                                                                    
          end

            # [ 
            # al_no.to_i, nl_no.to_i, shl_no.to_i, pl_no.to_i, gml_no.to_i,  
            # dl_no.to_i, ml_no.to_i, ol_no.to_i, kl_no.to_i, il_no.to_i
            # ]              
              
#_______________________________________

                                            
         order.struct_test_info = order.struct_test_info.to_s   + ' '     +
                                      'Al: '  + al_no  + ' ___ ' +       
                                      'Nl: '  + nl_no  + ' ___ ' +
                                      'Shl: ' + shl_no + ' ___ ' +
                                      'Pl: '  + pl_no  + ' ___ ' +                                        
                                      'Gml: ' + gml_no + ' __---__ '       +
                                      'Dl: '  + dl_no  + ' ___ ' +
                                      'Ml: '  + ml_no  + ' ___ ' +
                                      'Ol: '  + ol_no  + ' ___ ' +  
                                      'Kl: '  + kl_no  + ' ___ ' +
                                      'il: '  + il_no  + ' '
                                            
                                            
#_______________________________________      
              
        
          order.current_test_link        =  ''    
          
          order.current_qw_struct        =  ''                                                        

#_______________________________________


#_______________________________________

          
        if order.struct == 'il' and 5==3
                  
          order.save
          flash[:struct] = order.struct
          
          
          gender_rand_digit     = rand(0..9).to_s
          
          gender_details        = gender_rand_digit +
                                  order.id.to_s     +
                                  ' '               +
                                  order.akey[0..2] 
                                               
          gender_details_url    = Base64.encode64(gender_details).delete("\n").delete('=')
          
          
          redirect_to root_path + 'tests_gender/' + gender_details_url
          
#_______________________________________
          
                             
        else
                    
          load_want_to_db_after_test_struct(order)        
          
        end


                # end StructGroup Defining
        end   # end: if l_ind.count > 1                                                           
                            
#__________________________________________

          
      end    #----- End TestShow Part                

#_______________________________________            


      #end   # if order.current_test_link  and  order.current_test_link != test_url_encoded              
        ##end   # if  last_a["t"]   == cur_a["t"]       
      end   # if  order.current_test_link  and  last_a["t"]   == cur_a["t"]  
      
#_______________________________________            
      

    else  # unless order and order.akey[0..2] == order_akey
          # FAIL url
    
      #security_of_mailing = SecurityOfMailing.new
      #SecureMailer.wrong_url().deliver
      
      redirect_to root_path + 'info/' + 'dannue_receive_obrabotanu'    
      
    end   # if order and order.akey[0..2] == order_akey

  end
    
#_____________________________________________________________________________________________________________________________________________


  def struct_qws_signal_more
    
    details_encoded = params[:details_encoded]                 
    details_decoded = Base64.decode64 details_encoded
    
    details_arr     = details_decoded.split(' ')
    
#_______________________________________    


          #details_decoded             =   # for details_arr              
          #  order_id.to_s             + 
          #  ' '                       + 
          #  order_akey[0..2].to_s     +
          #  ' '                       +           
          #  max_names[0]              +
          #  ' '                       +           
          #  max_names[1]
    
    
    order_id    = details_arr[0]
    order_akey  = details_arr[1]

#_______________________________________

        
    order = Order.find(order_id)                    

#_______________________________________


    if order and order.akey[0..2] == order_akey
    
    
      max_group_1_index = details_arr[2]
      max_group_2_index = details_arr[3] 
      max_group_3_index = details_arr[4]       
      if details_arr[5] != nil            
        max_group_4_index = details_arr[5] 
      end      

#___________________            


      if max_group_1_index.to_i == max_group_2_index.to_i
      
        signal_struct_arr = order.signal_struct_arr.split(' ')         
        signal_struct_arr_i = []
        
        signal_struct_arr.each do |sign_struct_ar|        
          
          signal_struct_arr_i << case sign_struct_ar
            when 'al'
              '0'
            when 'nl'
              '1'              
            when 'shl'
              '2'              
            when 'pl'
              '3'                            
            when 'gml'
              '4'
              
            when 'dl'
              '5'
            when 'ml'
              '6'
            when 'ol'
              '7'
            when 'kl'
              '8'
            when 'il'
              '9'  
          end   # signal_struct_arr_i << case sign_struct_ar
          
        end   # signal_struct_arr.each do |sign_struct_ar|        

      

#___________________   

      
        max_group_1_index = signal_struct_arr_i[0]
        max_group_2_index = signal_struct_arr_i[1]
        max_group_3_index = signal_struct_arr_i[2]
      
        if signal_struct_arr_i[3] != nil            
          max_group_4_index = signal_struct_arr_i[3]
        end            

      end   # if max_group_1_index.to_i == max_group_2_index.to_i
      
                  
#_______________________________________            


      all_structs      = '0123456789'
      not_max_struct_i = all_structs.delete(max_group_1_index).delete(max_group_2_index)


      if max_group_3_index != nil
        not_max_struct_i = not_max_struct_i.delete(max_group_3_index)
      end
            
      if max_group_4_index != nil
        not_max_struct_i = not_max_struct_i.delete(max_group_4_index)
      end
      
#_______________________________________            


      not_max_struct =  ''                  
      not_max_struct_i.each_char do |not_max_st_i|
      
        not_max_struct += case not_max_st_i.to_i
              when 0
                'al '
              when 1
                'nl '              
              when 2
                'shl '              
              when 3
                'pl '                            
              when 4
                'gml '
                
              when 5
                'dl '
              when 6
                'ml '
              when 7
                'ol '
              when 8
                'kl '
              when 9
                'il'                                                                   
            end
        end
                    

      not_max_struct_arr = not_max_struct.split(' ')
      @qw_struct_signals = QwStructSignal.all
      
      not_max_struct_arr.each do |not_max_struct|
        @qw_struct_signals = @qw_struct_signals.where.not(struct: not_max_struct)
      end
      
#_______________________________________            

      
      @order = order
            
#_______________________________________            
      

    else  # unless order and order.akey[0..2] == order_akey
          # FAIL url
    
      #security_of_mailing = SecurityOfMailing.new
      #SecureMailer.wrong_url().deliver
      
      redirect_to root_path + 'info/' + 'dannue_receive_obrabotanu'    
      
    end   # if order and order.akey[0..2] == order_akey
        
      
  end

#_____________________________________________________________________________________________________________________________________________


  def signal_struct_more_array_save
    
    order_id   = params[:order_id]
    order_akey = params[:order_akey_start]

#______________________________________

    
    order = Order.find(order_id)
    	
#______________________________________

  
    if order and order.akey[0..2] == order_akey           
    
      signal_struct_arr            =  params[:order_signal_struct_more_array] || []

#_______________________________________

      
      if signal_struct_arr.count.in? 1..1

        
        current_struct             =  signal_struct_arr[0]                

#_______________________________________

        
        signal_struct_arr          =  signal_struct_arr.join(' ')
        order.struct               =  current_struct
        
        #order.signal_struct_done   =  true
        #order.save
        
#_______________________________________

          
        #if order.struct == 'il'
                  
        #  order.save
        #  flash[:struct] = order.struct
          
          
        #  gender_rand_digit     = rand(0..9).to_s
          
        #  gender_details        = gender_rand_digit +
        #                          order.id.to_s     +
        #                          ' '               +
        #                          order.akey[0..2] 
                                               
        #  gender_details_url    = Base64.encode64(gender_details).delete("\n").delete('=')
          
          
        #  redirect_to root_path + 'tests_gender/' + gender_details_url
          
#_______________________________________
          
                             
        #else   # unless order.struct == 'il'
                    
          load_want_to_db_after_test_struct(order)        
          
        #end   # if order.struct == 'il'
          
#_______________________________________          


      else   # signal_struct_arr.count NOT in? 1..3
        
                
        flash[:error_class_signal_struct_arr]                = 'error_field'           
        anchor = '#1'
        
#_______________________________________        


        max_names_1    = params[:max_names_1]
        max_names_2    = params[:max_names_2]
        
        if params[:max_names_2] != nil
          max_names_3  = params[:max_names_3]
        end
        
        
        structs_arr    = ['al',  'nl', 'shl', 'pl', 'gml', 
                          'dl', 'ml',  'ol', 'kl', 'il']
        
        max_names_1_i  = structs_arr.index(max_names_1)
        max_names_2_i  = structs_arr.index(max_names_2)
        
        if max_names_3 != nil
          max_names_3_i  = structs_arr.index(max_names_3)                
        end  
        
#_______________________________________        
        
          
          test_2_signal_more_array    =            
            order_id.to_s             + 
            ' '                       + 
            order_akey[0..2].to_s     +
            ' '                       +            
            max_names_1_i.to_s        +
            ' '                       +             
            max_names_2_i.to_s
                                          
          if max_names_3_i != nil
            test_2_signal_more_array += ' ' + max_names_3_i.to_s
          end                      


          test_2_signal_more_encoded  =  (Base64.encode64 test_2_signal_more_array).chomp.delete("\n").delete('=')        
          
          
          order.current_test_link     = 'tests_more/' + test_2_signal_more_encoded
          
          test_2_signal_more          =  root_path + 
                                         order.current_test_link
                              
          
          order.save                        
          redirect_to test_2_signal_more   # redirect to struct_qws_signal_more PAGE

      end   # signal_struct_arr.checkbox_has_1_3values            
        
    else   # unless order and order.akey == order_akey    

#_______________________________________

    
      #security_of_mailing = SecurityOfMailing.new
      #SecureMailer.wrong_url().deliver
      redirect_to root_path + 'info/' + 'dannue_receive_obrabotanu'  
    end   # signal_struct_arr.count.in? 1..3
    
  end
  
#__________________________________________________________________________________________________________________________________________________


  def form_gender_if_il_struct
  
    details_encoded = params[:details_encoded]
    details         = Base64.decode64 details_encoded
    
    details[0]      = ''    
    details_arr     = details.split(' ')

#_______________________________________    


    order_id        = details_arr[0]
    order_akey      = details_arr[1]    
    
    
    order           = Order.find(order_id)

#_______________________________________
  
  
    if order and order.akey[0..2] == order_akey                      
  
      @order = order
      
    else   # unless order and order.akey == order_akey    

#_______________________________________

    
      #security_of_mailing = SecurityOfMailing.new
      #SecureMailer.wrong_url().deliver
      
      redirect_to root_path + 'info/' + 'dannue_receive_obrabotanu'  
      
    end   # if order and order.akey[0..2] == order_akey           
            
  end

#__________________________________________________________________________________________________________________________________________________


  def save_gender_if_il_struct
  
  
    order_id        = params[:order_id]
    order_akey      = params[:order_akey]      

#_______________________________________

    
    order           = Order.find(order_id)

#_______________________________________
  
  
    if order and order.akey[0..2] == order_akey                      

      if params[:order_gender] 

#_______________________________________
     

        order.gender = params[:order_gender]
        order.save

  
        #load_want_to_db_after_test_struct(order)  
        
#_______________________________________
                              

        #QUESTIONS
        test           =  Test.find_by         number_of_test: 1
        questions_all  =  test.questions
        questions_on   =  questions_all.where  able: true          
        #questions      =  questions_on.where   for_yes_answer_plus_1_point_to: current_struct

#_______________________________________


        # PARAMS with QWS NUMBERS
        # cur_user_qws
        # cuq_ 
        
        cuq_signal_structs         = order.signal_struct_arr.split(' ')
        
        
        cuq_all_qws_numbers_array  = []                
        
        cuq_signal_structs.each do |struct|
          cuq_all_cur_user_qws     = questions_on.where for_yes_answer_plus_1_point_to: struct
          
          cuq_all_cur_user_qws.each do |cuq|
            cuq_all_qws_numbers_array << cuq.number_of_question.to_s
          end 
        end  
        
        
        cuq_all_qws_numbers_shuffle    = cuq_all_qws_numbers_array.shuffle
        cuq_all_qws_numbers_params     = cuq_all_qws_numbers_shuffle.join(' ')
        
        cuq_all_qws_numbers_params    += ' ' + rand(0..9).to_s + rand(0..9).to_s
        cuq_all_qws_numbers_params_64  = (Base64.encode64 cuq_all_qws_numbers_params).delete("\n").delete('=')

#_______________________________________
        
              
        #QUESTION
          
        #question       =  questions.first
        qw_number      =  cuq_all_qws_numbers_shuffle.first
        current_struct = cuq_signal_structs.first
        #qw_number      =  question.number_of_question        
 
     
        test_url_hash  =  {
  
          t:     '1',
          q:     qw_number,
          oi:    order.id,
          oa:    order.akey[0..2],
            
          a:     '0',
          n:     '0',
          s:     '0',
          p:     '0',
          g:     '0',
          d:     '0',
          m:     '0',
          o:     '0',
          k:     '0',
          i:     '0',                            
            
          cur_s: current_struct
          }        
        
        test_url_json    = JSON.generate(test_url_hash)        
        test_url_encoded_64 = (Base64.encode64 test_url_json).chomp.delete("\n").delete('=')        
        test_url = root_path + 'tests_s/' + test_url_encoded_64 
        
#_______________________________________


        test_url_qws = test_url + '?qs=' + cuq_all_qws_numbers_params_64

        redirect_to  test_url_qws 
          
#_______________________________________      

        
      else

        flash[:error_class_order_gender] = 'error_field'

#_______________________________________      


        gender_rand_digit     = rand(0..9).to_s
          
        gender_details        = gender_rand_digit +
                                order.id.to_s     +
                                ' '               +
                                order.akey[0..2] 
                                               
        gender_details_url    = Base64.encode64(gender_details).delete("\n").delete('=')
          
          
        redirect_to root_path + 'tests_gender/' + gender_details_url

      end  
      
    else   # unless order and order.akey == order_akey    

#_______________________________________

    
      #security_of_mailing = SecurityOfMailing.new
      #SecureMailer.wrong_url().deliver
      
      redirect_to root_path + 'info/' + 'dannue_receive_obrabotanu'  
      
    end   # if order and order.akey[0..2] == order_akey           
        
  end

#__________________________________________________________________________________________________________________________________________________

  
  
  private
  

    def set_root
      root_path   = MeConstant.find_by_title('root_path').content    
    end
    
    def set_info
      @site_title = MeConstant.find_by_title('site_title').content
      @main_page  = MainPage.find(1)   
      
      @page       = Page.find_by_page :test                
    end      
  
end
