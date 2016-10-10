require 'uri'
require 'openssl'
class TestsController < ApplicationController


  before_action :set_main_page, only: [:load_page,        :level_qws_body,  :level_qws_signal_more]
  before_action :set_root,      only: [:level_qws_signal, :level_qws_body,  :level_qws_signal_more]
  before_action :set_info,      only: [:level_qws_signal, :level_qws_body,  :level_qws_signal_more]  
#_____________________________________________________________________________________________________________________________________________


  def level_qws_signal

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
      
        order.current_test_link = 'testo/' + test_url_encoded          
        
      else
        if order.current_test_link != 'testo/' + test_url_encoded
          redirect_to root_path + order.current_test_link	
        end  
      end   # unless order.current_test_link == '' or order.current_test_link == nil                     

#______________________________________


      @qw_level_signals = QwLevelSignal.all
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
    #  :q  => #{@order.current_qw_level or '1'},
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


  def signal_level_array_save
    
    order_id   = params[:order_id]
    order_akey = params[:order_akey_start]
    
    order = Order.find(order_id)
    
#______________________________________

  
    if order and order.akey[0..2] == order_akey           
    
      signal_level_arr            =  params[:order_signal_level_array] || []

#_______________________________________

      
      if signal_level_arr.count.in? 1..2

        
        current_level             =  signal_level_arr[0]                

#_______________________________________

        
        signal_level_arr          =  signal_level_arr.join(' ')
        order.signal_level_arr    =  signal_level_arr
        
        order.signal_level_done   =  true
        order.save
        
#_______________________________________
        
              
        #QUESTIONS
        test           =  Test.find_by         number_of_test: 2
        questions_all  =  test.questions
        questions_on   =  questions_all.where  able: true          
        questions      =  questions_on.where   for_yes_answer_plus_1_point_to: current_level          
          
        question       =  questions.first
        qw_number      =  question.number_of_question
 
     
        test_url_hash  =  {
  
          t:     '2',
          q:     qw_number,
          oi:    order.id,
          oa:    order.akey[0..2],
            
          ps:    '0',
          po:    '0',
          ne:    '0',                            
            
          cur_l: current_level
          }        
        
        test_url_json    = JSON.generate(test_url_hash)        
        test_url_encoded_64 = (Base64.encode64 test_url_json).chomp.delete("\n")        
        test_url = root_path + 'tests/' + test_url_encoded_64 
        
        redirect_to test_url   
          
#_______________________________________          


      else   # signal_level_arr.count NOT in? 1..3
        
                
        flash[:error_class_signal_level_arr]                = 'error_field'           
        anchor = '#1'
        
#_______________________________________

        
        test_url_hash = {
          oi: order.id,
          oa: order.akey[0..2]
        }        
        
        test_url_json    = JSON.generate(test_url_hash)        
        test_url_encoded_64 = (Base64.encode64 test_url_json).chomp.delete("\n").delete('=')        
        test_url = root_path + 'testo/' + test_url_encoded_64
        
        
        redirect_to test_url + anchor

      end   # signal_level_arr.checkbox_has_1_3values            
        
    else   # unless order and order.akey == order_akey    

#_______________________________________

    
      #security_of_mailing = SecurityOfMailing.new
      #SecureMailer.wrong_url().deliver
      redirect_to root_path + 'info/' + 'dannue_receive_obrabotanu'  
    end   # signal_level_arr.count.in? 1..3
    
  end

#_____________________________________________________________________________________________________________________________________________


  def load_text_between_tests_level_struct(order, order_id, order_akey)
  
    
          order.group = 'GOOD GROUP'  if order.level == 'nevrotick'                        
          order.group = 'BAD GROUP'   if order.level == 'pogranichnick'        
          order.group = 'BAD GROUP'   if order.level == 'psihotick'        

#_______________________________________            


          level = 'ps'    if order.level == 'psihotick'
          level = 'po'    if order.level == 'pogranichnick'
          level = 'ne'    if order.level == 'nevrotick'        
          
#_______________________________________
        

          current_qw_struct_i = order.current_qw_struct.to_i
          
          if current_qw_struct_i == 0
            cur_struct_qw        = ((Question.where test: 1).where number_of_question: 1).first          
          end      
          
          if current_qw_struct_i != 0
            cur_struct_qw        = ((Question.where test: 1).where number_of_question: order.current_qw_struct).first          
          end      
                    
          cur_struct             = cur_struct_qw.for_yes_answer_plus_1_point_to
            
          test_1_start_url_hash  =  {
        
            l:      level,
            t:      '1',
            q:      "#{order.current_qw_struct or '1'}",        
            oi:     order_id,
            oa:     order_akey,
            cur_s:  cur_struct,          
          
            a:      '0',
            n:      '0',
            s:      '0',
            p:      '0',
            g:      '0',
            d:      '0',
            m:      '0',
            o:      '0',
            k:      '0',
            i:      '0'
          }        

#_______________________________________


          test_1_start_url_json     = JSON.generate(test_1_start_url_hash)
          test_1_start_url_encoded  = (Base64.encode64 test_1_start_url_json).chomp.delete("\n").delete('=')
        
          test_1_start_url          =  root_path                + 
                                    'infos/'                  + 
                                    'tekst_mezhdy_testami/'   + 
                                     test_1_start_url_encoded                                            

#__________________________________________      
      
      
          unless order.test_2_ended
            OrderMailer.b_to_test_2_levels(order, test_1_start_url).deliver                          
          end              
      
      
          order.test_2_ended     = true      
          
          order.current_qw_level = ''
      
#__________________________________________      

        
          order.save
          redirect_to     test_1_start_url  
  end
  
#_____________________________________________________________________________________________________________________________________________

  
  def level_qws_body

          # ['c'] ------controller   # no
          # ['an']------action name  # no
                      
          # ['t']       test_number
          # ['q']       qw_number  
          # ['oi']      order_id   
          # ['oa']      order_akey 
          
          # ['ps']      psihot     
          # ['po']      pogranich  
          # ['ne']      nevrot     
          
          # ['cur_l']   current_level (of qws)

#_______________________________________    

  
    test_url_encoded  = params[:test_encrypted]                 
    
    test_url_json     = Base64.decode64(test_url_encoded)    
    test_url_hash     = JSON.parse(test_url_json)
    
#_______________________________________    

    
    #test_number = test_url_hash['t'].to_i    
    
    order_id    = test_url_hash['oi']
    order_akey  = test_url_hash['oa']

#_______________________________________

        
    order = Order.find(order_id)                    
    
#_______________________________________      

      
    #if order.test_2_ended                                  # if Test2 has ended previously
    #  redirect_to root_path + 'info/test_yzhe_proyden'       # Redirect immediately to explaining Msg
    #end        
    
#_______________________________________


    if order and order.akey[0..2] == order_akey

#_______________________________________    

        
      qw_number      = test_url_hash['q'].to_i             
    
      #next_qw_number = qw_number + 1                    
      #next_qw_number_struct = (qw_number + 1).to_s   # ?           
    
#_______________________________________

    
      test_url_encoded = 'tests/' + test_url_encoded    
      
#_______________________________________


      #if order.current_test_link  and  order.current_test_link != test_url_encoded              
      
      #  redirect_to   root_path   +    order.current_test_link        
      #else   # if order.current_test_link  and  order.current_test_link != test_url_encoded                

#_______________________________________


      cur_answs = current_answers_hash = test_url_hash            
      
      last_answers_encoded          = order.current_test_link.partition('/').last   # just text after '/'
      last_answers_json             = Base64.decode64(last_answers_encoded)    
      
      last_a = last_answers_hash    = JSON.parse(last_answers_json)      
      cur_a  = cur_answs            # cur_answs  = current_answers_hash = test_url_hash
              
      
      #if (  order.current_test_link == ''  or  order.current_test_link == nil  and
      if  order.current_test_link                      and  
          order.current_test_link != test_url_encoded  and  
          last_a['t']     == cur_a['t']                and
          last_a['cur_l'] >  cur_a['cur_l']            and          
          last_a['q']     >  cur_a['q']  
           
            
        #if  last_a["t"]   == cur_a["t"]               
          redirect_to root_path + order.current_test_link
        
        else   #  unless  order.current_test_link  and  last_a["t"]   == cur_a["t"]   
               ## unless last_a["t"]   == cur_a["t"]                       
        
        ##end   # if  last_a["t"]   == cur_a["t"]       
          
      #end   # if  order.current_test_link  and  last_a["t"]   == cur_a["t"]  

#_______________________________________

      
      if qw_number.to_i == 1
            
        if order.current_test_link and cur_answs   # going to REDIRECT to cur test PROGRESS PAGE
                                                   
          if order.current_qw_level
      
      
            cur_test_link_encoded            = order.current_test_link.partition('/').last   # just text after '/'
            cur_test_link_json               = Base64.decode64(cur_test_link_encoded)    
        
            cur_link  = cur_test_link_hash   = JSON.parse(cur_test_link_json)        
          
          
            if cur_link['q'].to_i != cur_answs['q'].to_i
            
              #order.save
              redirect_to root_path + order.current_test_link              
            end
        
          end   # if order.current_qw_struct  
        end   # if order.current_test_link
      end   # if qw_number.to_i == 1      
  
#_______________________________________


      #current_test_link  =  order.current_test_link
      
      #order.current_test_link = test_url_encoded        
      
#_______________________________________      

 
      #SET CURRENT LEVEL OF QWS
      current_level    =  test_url_hash['cur_l']   # current level (of qws)    
    
#_______________________________________

      
      #QUESTIONS
      test             =  Test.find_by              number_of_test: 2
      questions_all    =  test.questions
      questions_on     =  questions_all.where       able: true                
      #questions
      #.limit(1)          
            
#_______________________________________      

    
      #QUESTION
      question         =  questions_all.find_by     number_of_question: qw_number                 
    
#_______________________________________      


      #DEFINE YES count
      psihot_no     = test_url_hash['ps']
      pogranich_no  = test_url_hash['po']
      nevrot_no     = test_url_hash['ne']
    
#_______________________________________
        
        
        unless order.current_test_link == '' or order.current_test_link == nil
    
    
          if  last_a['t']   == cur_a['t'] 
                              
                
              if  (  last_a['ps'].to_i   ==  cur_a['ps'].to_i  and
                     last_a['po'].to_i   ==  cur_a['po'].to_i  and
                     last_a['ne'].to_i   ==  cur_a['ne'].to_i  and
                   
                     order.yes_qws_level[-2] != '|'  )
              
                   
                yes_qws_level       =  order.yes_qws_level.split(' ')                                 
                yes_qws_level.pop   
                #unless yes_qws_level.last == '||'
              
                order.yes_qws_level = yes_qws_level.join(' ')
                

              end   # if YES wasn`t addes (on prew page)
            
      
          end   # if last_a["t"] == cur_a["t"]
         
        end   # unless order.current_test_link == '' or order.current_test_link == nil    
            
#_______________________________________              

                                                                                                            
      #if  question  and  (qw_number < questions.count + 1) and next_question    #----- Start TestShow Part
      
      if  question   #----- Start TestShow Part                  


        order.yes_qws_level << ' ' << qw_number.to_s << '.'   # save cur qw_number to YES order array                 

#_______________________________________      


        order.current_test_link = test_url_encoded

#_______________________________________      
    
    
        #~NEXT QUESTION (if exist)
        questions_cur_l  =  questions_all.where       for_yes_answer_plus_1_point_to: current_level          
          
        cur_qw_index     =  questions_cur_l.index(question)
        
                        
        next_qw_index    =  cur_qw_index + 1
        next_question    =  questions_cur_l[next_qw_index]
          
        if next_question
        
          next_qw_number =  next_question.number_of_question    
          
        else 
        
          signal_level_arr     =  order.signal_level_arr.split(' ')       # get array of EXIST LEVELS
          current_l_index      =  signal_level_arr.index(current_level)   # index of CURRENT LEVEL in array
          next_level           =  signal_level_arr[current_l_index + 1]   # get NEXT level
        
          questions_new_cur_l  =  questions_all.where  for_yes_answer_plus_1_point_to: next_level   # get QWS with this level
          
                            
          if questions_new_cur_l[0]   # if there are qws with THIS LEVEL
        
            next_question      =  questions_new_cur_l[0]             # get next QW (if there are qws with THIS LEVEL)
            next_qw_number     =  next_question.number_of_question   # get next QW number (for hash)            
          
            current_level      =  next_level   # for cur_l in HASH
          else
          
            next_qw_number     = Question.all.count + 1  # set UNDER LIMIT number of NEXT QW (for test will ended)
          end              
           
        end  
    
#_______________________________________

      
        @question    =  question          
        
        @qw_number   = qw_number        
            
#_______________________________________


        #order.current_qw_level = if qw_number <= questions.count
        #    qw_number.to_s
        #  else  
        #    ''
        #  end            
        
        order.current_qw_level = qw_number.to_s
          
#_______________________________________


        #NO HASH
        no_params_hash = {
          t:    '2',
          q:    next_qw_number,
          oi:   order_id,
          oa:   order_akey[0..2],
          ps:   "#{psihot_no or '0'}",  
          po:   "#{pogranich_no or '0'}",
          ne:   "#{nevrot_no or '0'}",                            
            
          cur_l: current_level
        }
    
#_______________________________________      

    
        #NO LINK
        no_params_json     = JSON.generate(no_params_hash)
        no_params_encoded  = (Base64.encode64 no_params_json).chomp.delete("\n").delete('=')
        
        @no_params         =  root_path         + 
                             'tests/'           + 
                              no_params_encoded
        
#_______#________________________________      


        #if question.able == false   # for existing, but OFFed QWS
      
        #  no_params_hash = {      
        #    t:   '2',
        #    q:   next_qw_number,
        #    oi:  order_id,
        #    oa:  order_akey[0..2],
        #    ps:  "#{psihot_no or '0'}",
        #    po:  "#{pogranich_no or '0'}",
        #    ne:  "#{nevrot_no or '0'}"
        #  }  
      
        #  no_params_json          = JSON.generate(no_params_hash)
        #  no_params_encoded       = (Base64.encode64 no_params_json).chomp.delete("\n").delete('=')      
      
        #  order.current_test_link = 'tests/'           + 
        #                           no_params_encoded
        
        #  order.save        
        #  redirect_to  root_path  +  order.current_test_link   # redirect to NEXT QW        
      
        #end   ### if question and question.able == false    
        
#_______________________________________      


        #DEFINE YES count
        case       question.for_yes_answer_plus_1_point_to
          when 'ps' 
            then   psihot_yes    = (psihot_no.to_i + 1).to_s
          when 'po' 
            then   pogranich_yes = (pogranich_no.to_i + 1).to_s
          when 'ne' 
            then   nevrot_yes    = (nevrot_no.to_i + 1).to_s
        end      
      
        
        #YES HASH      
        yes_params_hash = {
          t:   '2',
          q:   next_qw_number,
          oi:  order_id,
          oa:  order_akey[0..2],
          ps:  "#{psihot_yes or psihot_no or '0'}",
          po:  "#{pogranich_yes or pogranich_no or '0'}",
          ne:  "#{nevrot_yes or nevrot_no or '0'}",                            
            
          cur_l: current_level
        }                        

#_______________________________________      


        #YES LINK    
        yes_params_json     = JSON.generate(yes_params_hash)
        yes_params_encoded  = (Base64.encode64 yes_params_json).chomp.delete("\n").delete('=')
    
        @yes_params         =  root_path          + 
                              'tests/'            + 
                               yes_params_encoded      
    
#_______________________________________      

         
        # ?    
        #@current_question = qw_number.to_s         # ?
        #@questions_amount = questions.count.to_s   # ?
      
#_______________________________________            


        order.save

#_______________________________________            


      else   #----- TestShow Part
              #     unlesss question  (TEST was ENDED)

#_______________________________________            

    
        l_arr = levels_array    = [psihot_no.to_i, pogranich_no.to_i, nevrot_no.to_i]      # count of ДА in every ResultLevelGroups
        max_l = max_level_count = levels_array.max                                         # max count of points

        l_ind = level_indexes   = l_arr.each_index.select{                                 # Indexes of Level(s) with MaxPoints
                                  |i| l_arr[i] == max_l }        

#_______________________________________

      
        if l_ind.count > 1            
                                                        # if more then 1 LevelGroup with MaxPoints
                                                        
          
          #if 5==3   # SKIP fail        
          ## if LEVEL defining FAIL
          #order.level               = 'FAIL'          
          
                    
          #if order.level_test_info.to_s.size > 2000
          
          #  l_t_i                   = order.level_test_info
          #  order.level_test_info   = l_t_i.slice( (l_t_i.index('||')+3)..l_t_i.length)  unless l_t_i 

          #  y_q_l                   = order.yes_qws_level
          #  order.yes_qws_level     = y_q_l.slice( (y_q_l.index('||')+3)..y_q_l.length)  unless y_q_l
          #end
          
          #order.level_test_info     =  order.level_test_info.to_s + ' '   +
          #                            'Ps: '      + psihot_no     + ' _ ' +       
          #                            'Po: '      + pogranich_no  + ' _ ' +
          #                            'Ne: '      + nevrot_no            +                                   
          #                            ' - is FAIL || '
                                      
          #order.yes_qws_level       =  order.yes_qws_level        +
          #                             ' - is FAIL || '                                           
           
           
          #current_level_fail        =  order.signal_level_arr.split(' ')[0]
                    
          #current_level_fail_qws    =  questions_on.where for_yes_answer_plus_1_point_to: current_level_fail                     
          #first_qw                  =  current_level_fail_qws.first
          #first_qw_number           =  first_qw.number_of_question
          
          #order.current_qw_level    =  first_qw_number          
           
          #test_2_again_url_hash     =  {
          #  t:  '2',
          #  q:  first_qw_number,
          #  oi: order_id,
          #  oa: order_akey[0..2],
          #  ps: '0',
          #  po: '0',
          #  ne: '0',                            
            
          #  cur_l: current_level_fail
          #}        

          #test_2_again_url_json     =  JSON.generate(test_2_again_url_hash)
          #test_2_again_url_encoded  =  (Base64.encode64 test_2_again_url_json).chomp.delete("\n").delete('=')        
          
          #test_2_again_url          =  root_path + 
          #                            'infos/test_proyden_neverno/' + 
          #                             test_2_again_url_encoded                            
          
          #order.current_test_link   =  'tests/' + test_2_again_url_encoded
          
          #order.save                        
          #redirect_to test_2_again_url   # redirect to Level Test - Start (again)
        
          #end   # of SKIPING fail
          
#_______________________________________        

          
          #test_2_signal_more_hash   =  {
            #t:  '2',
            #q:  first_qw_number,
          #  oi: order_id,
          #  oa: order_akey[0..2],
            #ps: '0',
            #po: '0',
            #ne: '0'                            
            
            #cur_l: current_level_fail
          #}        
          
#_______________________________________        

          
          max_names = ''      # if same count in diffrent groups - define variable for GroupsNAMES                                   
            
          l_arr.each.with_index do |el, i|                     
            if el == max_l 
              max_names += '1 ' if i == 0
              max_names += '2 ' if i == 1
              max_names += '3'  if i == 2
            end
          end         
          
          max_names = max_names.split(' ')    

#_______________________________________        

          
          test_2_signal_more_array    =            
            order_id.to_s             + 
            ' '                       + 
            order_akey[0..2].to_s     +
            ' '                       +            
            max_names[0]              +
            ' '                       +             
            max_names[1]
                              

          #test_2_signal_more_json     =  JSON.generate(test_2_signal_more_hash)
          test_2_signal_more_encoded  =  (Base64.encode64 test_2_signal_more_array).chomp.delete("\n").delete('=')        
          
          
          order.current_test_link     = 'testo_more/' + test_2_signal_more_encoded
          
          test_2_signal_more          =  root_path + 
                                         order.current_test_link
          
          
          order.level_test_info          =   order.level_test_info.to_s    + ' '     +
                                            'Psihot: '      + psihot_no    + ' ___ ' +       
                                            'Pogranich: '   + pogranich_no + ' ___ ' +
                                            'Nevrot: '      + nevrot_no                         
          
          order.save                        
          redirect_to test_2_signal_more   # redirect to level_qws_signal_more PAGE
          
#_______________________________________        

                
        else                                                                          # if just 1 max LevelGroupResult -> define the Group
               # unless l_ind.count > 1                                                                  
               
          # if LEVEL defined SUCCESS          
          order.level = if levels_array.index(levels_array.max) == 0
            'psihotick'           
            
          elsif levels_array.index(levels_array.max) == 1                   
            'pogranichnick'                        
                 
          else  
            'nevrotick'
            
          end          
              
#_______________________________________


          order.level_test_info          =   order.level_test_info.to_s    + ' '     +
                                            'Psihot: '      + psihot_no    + ' ___ ' +       
                                            'Pogranich: '   + pogranich_no + ' ___ ' +
                                            'Nevrot: '      + nevrot_no 
                                            
#_______________________________________      
              
        
          order.current_test_link        =  ''    
          
          order.current_qw_level         =  ''                                                        

#_______________________________________


          #DEF
          load_text_between_tests_level_struct(order, order_id, order_akey)


        end                                                                           # end LevelGroup Defining
              # end: if l_ind.count > 1                                                           
                            
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


  def level_qws_signal_more
    
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
      
#_______________________________________            


      all_levels      = '123'
      not_max_level_i = all_levels.delete(max_group_1_index).delete(max_group_2_index)
      
#_______________________________________            


      not_max_level = case not_max_level_i.to_i
        when 1
          'ps'
        when 2
          'po'
        when 3
          'ne'
      end
                    
      @qw_level_signals = QwLevelSignal.where.not(level: not_max_level)
      
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


  def signal_level_more_array_save
    
    order_id   = params[:order_id]
    order_akey = params[:order_akey_start]

#______________________________________

    
    order = Order.find(order_id)
    
#______________________________________

  
    if order and order.akey[0..2] == order_akey           
    
      signal_level_arr            =  params[:order_signal_level_more_array] || []

#_______________________________________

      
      if signal_level_arr.count.in? 1..1

        
        current_level             =  signal_level_arr[0]                

#_______________________________________

        
        signal_level_arr          =  signal_level_arr.join(' ')
        order.level    =  signal_level_arr
        
        #order.signal_level_done   =  true
        #order.save
        
#_______________________________________
        
        
          # if LEVEL defined SUCCESS          
          order.level = case order.level
            when 'ps'
              'psihotick'           
            
            when 'po'
              'pogranichnick'                        
                 
            when 'ne'
              'nevrotick'
            
          end                  
          
#_______________________________________

          
        #DEF      
        load_text_between_tests_level_struct(order, order_id, order_akey)
          
#_______________________________________          


      else   # signal_level_arr.count NOT in? 1..3
        
                
        flash[:error_class_signal_level_arr]                = 'error_field'           
        anchor = '#1'
        
#_______________________________________        


        max_names_1    = params[:max_names_1]
        max_names_2    = params[:max_names_2]
        
        
        max_names_1_i  = case max_names_1
          when 'ps'
            1
          when 'po'
            2
          when 'ne'
            3                        
        end  
        
        max_names_2_i  = case max_names_2
          when 'ps'
            1
          when 'po'
            2
          when 'ne'
            3                        
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
                                          

          test_2_signal_more_encoded  =  (Base64.encode64 test_2_signal_more_array).chomp.delete("\n").delete('=')        
          
          
          order.current_test_link     = 'testo_more/' + test_2_signal_more_encoded
          
          test_2_signal_more          =  root_path + 
                                         order.current_test_link
                              
          
          order.save                        
          redirect_to test_2_signal_more   # redirect to level_qws_signal_more PAGE

      end   # signal_level_arr.checkbox_has_1_3values            
        
    else   # unless order and order.akey == order_akey    

#_______________________________________

    
      #security_of_mailing = SecurityOfMailing.new
      #SecureMailer.wrong_url().deliver
      redirect_to root_path + 'info/' + 'dannue_receive_obrabotanu'  
    end   # signal_level_arr.count.in? 1..3
    
  end
  
#_____________________________________________________________________________________________________________________________________________
  
  
  def load_page 
    @page       = Page.find_by_page :test
  
    @site_title = MeConstant.find_by_title('site_title').content
      
    root_path   = MeConstant.find_by_title('root_path').content

#_______________________________________

    
    test_url_encoded = params[:test_encrypted]             
    
    #AES de3code    
    #test_url_encoded = test_url_encoded_aes_with_symbols = repl_all_subs('slash', '/', test_url_encoded)
    #    aes_key = 'asdfghjlqwyueuhgkl5'
    #    test_url_encoded = AES.encrypt(test_url_encoded, aes_key)                                                                

    
    test_url_json    = Base64.decode64(test_url_encoded)    
    test_url_hash    = JSON.parse(test_url_json)
    
    test_url_encoded = 'test/' + test_url_encoded
    
    test_number = test_url_hash["t"].to_i    
    qw_number   = test_url_hash["q"].to_i     

#_______________________________________

    
    if test_number == 1
      cur_s = test_url_hash["cur_s"]    
    end  
    
    @cur_s = cur_s
   
#_______________________________________

    
    order_id    = test_url_hash["oi"]
    order_akey  = test_url_hash["oa"]
        
    order = Order.find(order_id)            
    
#_______________________________________


    unless order.current_test_link == '' or order.current_test_link == nil
    
      last_answers_encoded = order.current_test_link.partition('/').last
      last_answers_json    = Base64.decode64(last_answers_encoded)    
      
      last_a = last_answers_hash    = JSON.parse(last_answers_json)      
      cur_a  = current_answers_hash = test_url_hash
      
      
      if last_a["t"] == cur_a["t"]
      
        if last_a["t"].to_i == 2   # ['ps'] ['po'] ['ne']          
                
          if last_a['ps'].to_i < cur_a['ps'].to_i  
            order.yes_qws_level << (qw_number - 1).to_s << '. '
          else
          
            if last_a['po'].to_i < cur_a['po'].to_i  
              order.yes_qws_level << (qw_number - 1).to_s << '. '
            else
            
              if last_a['ne'].to_i < cur_a['ne'].to_i  
                order.yes_qws_level << (qw_number - 1).to_s << '. '
              end   # ['ne']            
            
            end   # ['po']          
          
          end   # if last_a['ps'].to_i < cur_a['ps'].to_i
            
        end   # if last_a["t"].to_i == 2        # Struct
              
                            
                            
        if last_a["t"].to_i == 1   # ['a'] ['n'] ['s'] ['p'] ['g']   ['d'] ['m'] ['o'] ['k'] ['i']        

          if last_a['a'].to_i < cur_a['a'].to_i  
            order.yes_qws_struct << (qw_number - 1).to_s << '. '
          else
          
            if last_a['n'].to_i < cur_a['n'].to_i  
              order.yes_qws_struct << (qw_number - 1).to_s << '. '
            else
            
              if last_a['s'].to_i < cur_a['s'].to_i  
                order.yes_qws_struct << (qw_number - 1).to_s << '. '
              else
              
                if last_a['p'].to_i < cur_a['p'].to_i  
                  order.yes_qws_struct << (qw_number - 1).to_s << '. '
                else
                
                  if last_a['g'].to_i < cur_a['g'].to_i  
                    order.yes_qws_struct << (qw_number - 1).to_s << '. '
                  else
                
                    if last_a['d'].to_i < cur_a['d'].to_i  
                      order.yes_qws_struct << (qw_number - 1).to_s << '. '
                    else
                    
                      if last_a['m'].to_i < cur_a['m'].to_i  
                        order.yes_qws_struct << (qw_number - 1).to_s << '. '
                      else
                      
                        if last_a['o'].to_i < cur_a['o'].to_i  
                          order.yes_qws_struct << (qw_number - 1).to_s << '. '
                        else
                        
                          if last_a['k'].to_i < cur_a['k'].to_i  
                            order.yes_qws_struct << (qw_number - 1).to_s << '. '
                          else
                          
                            if last_a['i'].to_i < cur_a['i'].to_i  
                              order.yes_qws_struct << (qw_number - 1).to_s << '. '
                            end   # ['i']                                                     
                            
                          end   # ['k']                                                   
                          
                        end   # ['o']                                  
                        
                      end   # ['m']                                  
                      
                    end   # ['d']                            
                  
                  end   # ['g']                            
                  
                end   # ['p']                          
                
              end   # ['s']            
            
            end   # ['n']          
          
          end   # if last_a['a'].to_i < cur_a['a'].to_i

        end   # if last_a["t"].to_i == 1       ### Levels 
      
      
      
      end   # if last_a["t"] == cur_a["t"]
       
    end   # unless order.current_test_link == '' or order.current_test_link == nil    

#_______________________________________
    
    
    if qw_number.to_i == 1
     if test_number == 2      
      if order.current_test_link and cur_a
        if order.current_qw_struct or order.current_qw_level
      
          cur_test_link_encoded            = order.current_test_link.partition('/').last
          cur_test_link_json               = Base64.decode64(cur_test_link_encoded)    
        
          cur_link  = cur_test_link_hash   = JSON.parse(cur_test_link_json)        
          cur_answs = cur_a
          
          if cur_link['q'].to_i != cur_answs['q'].to_i
            redirect_to root_path + order.current_test_link
            #redirect_to root_path + 'test/' + order.current_test_link
          end
        
        end   # if order.current_qw_struct  
      end   # if order.current_test_link
     end   # if test_number == 2       
    end   # if qw_number.to_i == 1
    
#_______________________________________


    order.current_test_link = test_url_encoded
    order.save    
    
#_______________________________________

    
    questions = Test.find_by(number_of_test: test_number).questions
    #.limit(3)          

    ##questions = questions.where(able: true)    
    ##if qw_number < questions.count + 1
    #flash[:error_mi] = ''
    
    
    
    #if test_number == 1
    #  if qw_number == 1
    #    qw_number = 1 if test_url_hash["l"] == 'ps'  #start from 1st qw if current level is 'psihot'
    #    qw_number = 3 if test_url_hash["l"] == 'p'
    #    qw_number = 5 if test_url_hash["l"] == 'n'
    #  end
    #end     
    
#_______________________________________________________________________________                                          
        
        
    if test_number == 2
      order.current_qw_level = if qw_number <= questions.count
          qw_number.to_s
        else  
          ''
        end
        
      order.signal_level_done = true unless order.signal_level_done        
    end
            
    
    if test_number == 1 
      order.current_qw_struct = if qw_number <= questions.count
          qw_number.to_s
        else  
          ''
        end
        
      order.signal_struct_done = true unless order.signal_level_done 
    end     
    
    order.save         
    
#_______________________________________________________________________________            

    
    if test_number == 1 
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
      #disl_no = test_url_hash['di']
    end  
    
    if test_number == 2 
      psihot_no     = test_url_hash['ps']
      pogranich_no  = test_url_hash['po']
      nevrot_no     = test_url_hash['ne']
    end    
    
#_______________________________________________________________________________            
             

        level = 'ps' if order.level == 'psihotick'
        level = 'p' if order.level == 'pogranichnick'
        level = 'n' if order.level == 'nevrotick'             
        
#_____________________________________

        
      next_qw_number = (qw_number + 1).to_s        
      
#_______________________________________________________________________________            

      
      next_qw_number_struct = (qw_number + 1).to_s        
      
      #GET ALL QWS WITH CUR_STRUCT TO Q_COLLECTION(qs)     qs=Question.where for_yes_answer_plus_1_point_to: cur_s
      #GET INDEX OF CUR_QW IN Q_COLLECTION(qs)             qs.index(q)
      #AND TRY TO GET NEXT Q WITH CUR STRUCT               next_q = qs[qs.index(q)+1]
      #IF NEXT_Q IN CUR_STRUCT EXIST SET NEXT_NUMBER_OF_QW next_number_of_q = next_q.number_of_question                
    
#_____________________________________

    
    question = questions.find_by_number_of_question(qw_number)  
    
    if question and question.able == false
     if test_number == 1         
     
       cur_struct = ((Question.where test: 1).where number_of_question: qw_number).first.for_yes_answer_plus_1_point_to     
     
       no_params_hash = {
        :c  => 'tests', 
        :an      => 'load_page', 
        :t => '1',
        :l       => level,        
        :q   => next_qw_number_struct,
        :oi    => order_id,
        :oa  => order_akey,
        :a          => "#{al_no or '0'}",
        :n          => "#{nl_no or '0'}",
        :s         => "#{shl_no or '0'}",
        :p          => "#{pl_no or '0'}",
        :g         => "#{gml_no or '0'}",
        :d          => "#{dl_no or '0'}",
        :m          => "#{ml_no or '0'}",
        :o          => "#{ol_no or '0'}",
        :k          => "#{kl_no or '0'}",
        :i          => "#{il_no or '0'}",
        #:di        => "#{disl_no or '0'}",          
        :cur_s        => cur_struct        
      }
     end            
#__________________________________________            


    if test_number == 2         
      no_params_hash = {
        :c  => 'tests', 
        :an      => 'load_page', 
        :t => '2',
        :q   => qw_number + 1,
        :oi    => order_id,
        :oa  => order_akey,
        :ps      => "#{psihot_no or '0'}",
        :po   => "#{pogranich_no or '0'}",
        :ne      => "#{nevrot_no or '0'}"
      }
    end            
#__________________________________________        

        
        no_params_json = JSON.generate(no_params_hash)
        no_params_encoded_64 = (Base64.encode64 no_params_json).chomp.delete("\n")
        no_params_encoded = no_params_encoded_64 + '='
        no_params = root_path + "test/#{no_params_encoded}"
        order.current_test_link = 'test/' + "#{no_params_encoded}"
        order.save
        redirect_to no_params
  end             ### if question and question.able == false
    
     
    
    
    ###    
    #@questions = questions    
    #@qw_number = qw_number
    #def is_question_able
    #  @question = @questions.find_by_number_of_question(@qw_number)
    #  #flash[:error_mi] += "A qw with qw_number(#{qw_number}) found <br/>"
    #  if @question
    #    #flash[:error_mi] += 'B and qw exist <br/>'
    #    if @question.able == false    
    #      #flash[:error_mi] += 'C it`s disabled <br/>'
    #      if @questions.find_by_number_of_question(@qw_number + 1)
    #        @qw_number = @qw_number + 1 
    #      else
    #        @test_ended = true  
    #      end
    #      #flash[:error_mi] += 'D so inc(qw_number) <br/>'
    #    end  
    #  end  
    #  @question = @questions.find_by_number_of_question(@qw_number)
    #  
    #  if @question.able == false    
    #    is_question_able
    #  end
    #end
    #is_question_able
    ##flash[:error_mi] += "E seted qw with qw_number(#{qw_number}) again "
    #qw_number = @qw_number
    #question  = @question  
    #questions = @questions
    ###
#_______________________________________________________________________________

                  
    @qw_number  = qw_number    
    
                                                                                            #----- Start Testing Part
    if   (qw_number < questions.count + 1)  and  question
         #((((qw_number.in? 1..2 and test_url_hash['l'] == 'ps')    or 
         #  (qw_number.in? 3..4 and test_url_hash['l'] == 'p')  or 
         #  (qw_number.in? 5..6 and test_url_hash['l'] == 'n'))    and       
         #  test_number == 1)                                               or
         #  (test_number == 2 and qw_number < questions.count + 1) ) and 
         #                                                              question
                                                                       #@test_ended != true                        
       



      if test_number == 1 
        if order.test_1_ended                                                         # if Test1 has ended previously
          redirect_to root_path + 'info/test_yzhe_proyden'                          # Redirect immediately to explaining Msg
        end
      end
    
      if test_number == 2
        if order.test_2_ended                                                         # if Test2 has ended previously
          redirect_to root_path + 'info/test_yzhe_proyden'                          # Redirect immediately to explaining Msg
        end    
      end   

       
       
    
      question = questions.find_by_number_of_question(qw_number)
      @question_title = question.title
      @question       = question

     
      
      #next_qw_number = (qw_number + 1).to_s
#__________________________________________


    @current_question = qw_number.to_s
    @questions_amount = questions.count.to_s      
#__________________________________________
                        
            
    if test_number == 1            
      case question.for_yes_answer_plus_1_point_to
        when 'al' 
          then al_yes = (al_no.to_i + 1).to_s
        when 'nl' 
          then nl_yes = (nl_no.to_i + 1).to_s
        when 'shl' 
          then shl_yes = (shl_no.to_i + 1).to_s
        when 'pl' 
          then pl_yes = (pl_no.to_i + 1).to_s
        when 'gml' 
          then gml_yes = (gml_no.to_i + 1).to_s
        when 'dl' 
          then dl_yes = (dl_no.to_i + 1).to_s
        when 'ml' 
          then ml_yes = (ml_no.to_i + 1).to_s
        when 'ol' 
          then ol_yes = (ol_no.to_i + 1).to_s
        when 'kl' 
          then kl_yes = (kl_no.to_i + 1).to_s
        when 'il' 
          then il_yes = (il_no.to_i + 1).to_s
        #when 'disl' 
        #  then disl_yes = (disl_no.to_i + 1).to_s
      end      

      cur_struct = ((Question.where test: 1).where number_of_question: qw_number).first.for_yes_answer_plus_1_point_to
      
      yes_params_hash = {
        :c => 'tests', 
        :an => 'load_page',
        :t => '1', 
        :l       => level,
        :q => next_qw_number_struct,
        :oi => order_id,
        :oa => order_akey,
        :a => "#{al_yes or al_no or '0'}",
        :n => "#{nl_yes or nl_no or '0'}",
        :s => "#{shl_yes or shl_no or '0'}",
        :p => "#{pl_yes or pl_no or '0'}",
        :g => "#{gml_yes or gml_no or '0'}",
        :d => "#{dl_yes or dl_no or '0'}",
        :m => "#{ml_yes or ml_no or '0'}",
        :o => "#{ol_yes or ol_no or '0'}",
        :k => "#{kl_yes or kl_no or '0'}",
        :i => "#{il_yes or il_no or '0'}",
        #:di => "#{disl_yes or disl_no or '0'}",          
        :cur_s        => cur_struct        
      }
    end    

#__________________________________________    


    if test_number == 2
      case question.for_yes_answer_plus_1_point_to
        when 'ps' 
          then psihot_yes = (psihot_no.to_i + 1).to_s
        when 'p' 
          then pogranich_yes = (pogranich_no.to_i + 1).to_s
        when 'n' 
          then nevrot_yes = (nevrot_no.to_i + 1).to_s
      end      
      
      yes_params_hash = {
        :c   => 'tests', 
        :an       => 'load_page', 
        :t  => '2',
        :q    => next_qw_number,
        :oi     => order_id,
        :oa   => order_akey,
        :ps       => "#{psihot_yes or psihot_no or '0'}",
        :po    => "#{pogranich_yes or pogranich_no or '0'}",
        :ne       => "#{nevrot_yes or nevrot_no or '0'}"
      }    
    end                    
        
#__________________________________________        
        
        
        yes_params_json = JSON.generate(yes_params_hash)
        yes_params_encoded_64 = (Base64.encode64 yes_params_json).chomp.delete("\n")
        yes_params_encoded = yes_params_encoded_64 + '='
        @yes_params = root_path + "test/#{yes_params_encoded}"
#_______________________________________________________________________________

                        
         
    if test_number == 1         
    
     cur_struct = ((Question.where test: 1).where number_of_question: qw_number).first.for_yes_answer_plus_1_point_to    
    
      no_params_hash = {
        :c  => 'tests', 
        :an      => 'load_page', 
        :t => '1',
        :l       => level,        
        :q   => next_qw_number_struct,
        :oi    => order_id,
        :oa  => order_akey,
        :a          => "#{al_no or '0'}",
        :n          => "#{nl_no or '0'}",
        :s         => "#{shl_no or '0'}",
        :p          => "#{pl_no or '0'}",
        :g         => "#{gml_no or '0'}",
        :d          => "#{dl_no or '0'}",
        :m          => "#{ml_no or '0'}",
        :o          => "#{ol_no or '0'}",
        :k          => "#{kl_no or '0'}",
        :i          => "#{il_no or '0'}",
        #:di        => "#{disl_no or '0'}",          
        :cur_s        => cur_struct        
      }
      
    end            
#__________________________________________            


    if test_number == 2         
      no_params_hash = {
        :c  => 'tests', 
        :an      => 'load_page', 
        :t => '2',
        :q   => next_qw_number,
        :oi    => order_id,
        :oa  => order_akey,
        :ps      => "#{psihot_no or '0'}",
        :po   => "#{pogranich_no or '0'}",
        :ne      => "#{nevrot_no or '0'}"
      }
    end            
#__________________________________________        

        
        no_params_json = JSON.generate(no_params_hash)
        no_params_encoded_64 = (Base64.encode64 no_params_json).chomp.delete("\n")
        no_params_encoded = no_params_encoded_64 + '='
        @no_params = root_path + "test/#{no_params_encoded}"
        
        #order.current_test_link = "test/#{no_params_encoded}"
        #order.save
        
                                      
    else #----- Test ended
#_______________________________________________________________________________
                   

      #-if order and order.akey == order_akey #----- If Right Order                
        
                
      if test_number == 1        
      
        good_arr = [dl_no.to_i, ml_no.to_i, ol_no.to_i, pl_no.to_i, kl_no.to_i, il_no.to_i]
        #good_arr = [dl_no.to_i, ml_no.to_i, ol_no.to_i, pl_no.to_i, kl_no.to_i, il_no.to_i, disl_no.to_i]              
        bad_arr  = [al_no.to_i, nl_no.to_i, shl_no.to_i, gml_no.to_i]
        
        
        order.group = if good_arr.max > bad_arr.max         
          'GOOD GROUP'                     
        else                   
          'BAD GROUP'       
        end
        
        
        #order.structure == ' '
        
        
      #unless order.structure == 'FAIL'
        if order.group == 'GOOD GROUP'
        
          order.structure = case good_arr.index(good_arr.max)
          when 0
            'dl'
          when 1
            'ml'
          when 2
            'ol'
          when 3
            'pl'
          when 4
            'kl'
          when 5
            'il'
          #when 6
          #  'disl'            
          end        
          
        else   # UNLESS order.group == 'GOOD GROUP'

          order.structure = case bad_arr.index(bad_arr.max)
          when 0
            'al'
          when 1
            'nl'
          when 2
            'shl'
          when 3
            'gml'            
          end
                  
        end   # if order.group == 'GOOD GROUP'
                                
      #end   # unless order.structure = 'FAIL'  
      
      
        if good_arr.max > bad_arr.max         
          good_arr_eq      = good_arr
        
          good_max_1       = good_arr_eq.max
          good_max_index_1 = good_arr_eq.index(good_max_1)
          good_arr_eq.delete_at(good_max_index_1)
        
          good_max_2       = good_arr_eq.max
          
          if good_max_1.to_i == good_max_2.to_i
            order.structure = 'FAIL'
          end                          
        else            
        
          bad_arr_eq      = bad_arr
        
          bad_max_1       = bad_arr_eq.max
          bad_max_index_1 = bad_arr_eq.index(bad_max_1)
          bad_arr_eq.delete_at(bad_max_index_1)
        
          bad_max_2       = bad_arr_eq.max                
          
          if bad_max_1.to_i == bad_max_2.to_i
            order.structure = 'FAIL'
          end                        
        end
        
                
      
      
      
      end   # if test_number == 1          
#__________________________________________        


      if test_number == 2                                                       ### if 2nd Test (233)
      
        l_arr = levels_array    = [psihot_no.to_i, pogranich_no.to_i, nevrot_no.to_i]      # count in every ResultLevelGroups
        max_l = max_level_count = levels_array.max                                         # max count of points

        l_ind = level_indexes   = l_arr.each_index.select{                                 # Indexes of Level(s) with MaxPoints
                                  |i| l_arr[i] == max_l }        
      
        if l_ind.count > 1                                                            # if more then 1 LevelGroup with MaxPoints

          order.level = 'FAIL'
        
        else                                                                          # if just 1 max LevelGroupResult -> define the Group
          order.level = if levels_array.index(levels_array.max) == 0
            'psihotick'           
          elsif levels_array.index(levels_array.max) == 1                   
            'pogranichnick'                             
          else  
            'nevrotick'
          end
        end                                                                           # end LevelGroup Defining
        
                
        order.group = 'BAD GROUP' if order.level == 'pogranichnick'        
        order.group = 'BAD GROUP' if order.level == 'psihotick'
        
      end                                                                       ### END if 2nd Test (233)

#_______________________________________________________________________________
      

    if test_number == 1                             
      
#__________________________________________


      redirect_letter          = ('a'..'z').to_a.shuffle.first
      link_details             = order.id.to_s               + 
                                 redirect_letter             + 
                                 order.akey_payed
      link_details_encoded_64  = (Base64.encode64 link_details).chomp.delete("\n")
      
      #link_details_encoded     = link_details_encoded_64 + '=' 



            
      #key_pair  = RSA::KeyPair.generate(1024)
      #link_details_begin_ascii_8 = key_pair.encrypt(link_details_encoded)
      #link_details_begin_for_url = URI.encode(link_details_begin_ascii_8)         
      
            
      
      #link_details_begin_ascii_8 = key_pair.encrypt(link_details_encoded)      
      
      
      
      #link_details_begin = link_details_begin_for_url 
            
      #link_with_more_info_form = root_path + 'much_form/' + link_details_begin
      
      #-
      order_id_for_do_you_want_to_db = order.id.to_s
      oi_want_todb = order_id_for_do_you_want_to_db
      oi_want_todb = oi_want_todb.insert(oi_want_todb.length-1, (0..9).to_a.shuffle.first.to_s)
      order_id_for_do_you_want_to_db = oi_want_todb                
      
      next_page_after_test_2_level   = root_path + 'do_you_want_to_db/' + order_id_for_do_you_want_to_db
      OrderMailer.bx_2_events(order, next_page_after_test_2_level).try(:deliver)
      #link to much_form
      #next_page_after_test_2_level = 
      link_with_more_info_form = root_path + 'much_form/' + link_details_encoded_64                      
                   
#__________________________________________


      plus_2_letters           = ('a'..'z').to_a.shuffle.first + 
                                 ('A'..'Z').to_a.shuffle.first
                                                                                                   
      
      details                  = order.id.to_s                 + 
                                 plus_2_letters                + 
                                 '&'                           +
                                 order.akey_payed[0,3]                
                                 
                                 
      details  = (Base64.encode64 details).chomp.delete("\n")                                 
      
      
      link_with_contacts_again = root_path                     + 
                                'show-contacts/'               + 
                                 details                       
      
#__________________________________________

      
      unless order.test_1_ended
        OrderMailer.c_more_info_form(order, link_with_more_info_form, link_with_contacts_again).try(:deliver)      
      end              
            
                                           
        order.test_1_ended = true
        order.akey         = ''

#__________________________________________        
     
      
      if order.structure == 'FAIL'
      
        cur_struct = ((Question.where test: 1).where number_of_question: 1).first.for_yes_answer_plus_1_point_to      
      
        test_1_url_hash = {
          :l          => level,
          :t          => '1',
          :q          => '1',        
          :oi         => order_id,
          :oa         => order_akey,
          :a          => '0',
          :n          => '0',
          :s          => '0',
          :p          => '0',
          :g          => '0',
          :d          => '0',
          :m          => '0',
          :o          => '0',
          :k          => '0',
          :i          => '0',
          #:di         => '0',          
          :cur_s        => cur_struct                
        }        


        test_1_url_json = JSON.generate(test_1_url_hash)
        test_1_url_encoded_64 = (Base64.encode64 test_1_url_json).chomp.delete("\n")
        test_1_url_encoded = test_1_url_encoded_64 + '=' 
        
        test_1_url = root_path + 'infos/test_proyden_neverno/' + test_1_url_encoded                            
        
        
        
        next_page_after_test_2_level = link_with_test_2_levels = test_1_url                                          
        
        order.test_1_ended = false     
        order.yes_qws_struct = '' 
              
      
      end                          

#__________________________________________


        order.structure_test_info = 'Al: ' + al_no + ' ___ ' +       
                                    'Nl: ' + nl_no + ' ___ ' +
                                    'Shl: ' + shl_no + ' ___ ' +
                                    'Gml: ' + gml_no + ' __---__ ' +
                                    'Pl: ' + pl_no + ' ___ ' +
                                    'Dl: ' + dl_no + ' ___ ' +
                                    'Ml: ' + ml_no + ' ___ ' +
                                    'Ol: ' + ol_no + ' ___ ' +
                                    'Kl: ' + kl_no + ' ___ ' +
                                    'il: ' + il_no + ' '
     
                 
#__________________________________________                 
                 
                 
      order.current_test_link = ''                 
      order.save
      
      
      redirect_to next_page_after_test_2_level      
      
    end  #---End Test1
                          
#__________________________________________




    if test_number == 2             
    
        level = 'ps'    if order.level == 'psihotick'
        level = 'p' if order.level == 'pogranichnick'
        level = 'n'    if order.level == 'nevrotick'        
        
                
        cur_struct = ((Question.where test: 1).where number_of_question: "#{order.current_qw_struct or '1'}").first.for_yes_answer_plus_1_point_to
            
        test_2_url_hash =  {
          :l            => level,
          :t            => '1',
          :q            => "#{order.current_qw_struct or '1'}",        
          :oi           => order_id,
          :oa           => order_akey,
          :a            => '0',
          :n            => '0',
          :s            => '0',
          :p            => '0',
          :g            => '0',
          :d            => '0',
          :m            => '0',
          :o            => '0',
          :k            => '0',
          :i            => '0',
          #:di           => '0',          
          :cur_s        => cur_struct
        }        


        test_2_url_json = JSON.generate(test_2_url_hash)
        test_2_url_encoded_64 = (Base64.encode64 test_2_url_json).chomp.delete("\n")
        test_2_url_encoded = test_2_url_encoded_64 + '=' 
        #test_2_url = root_path + 'test/' + test_2_url_encoded
        test_2_url = root_path + 'infos/tekst_mezhdy_testami/' + test_2_url_encoded                            
                
        
        link_with_test_2_levels = test_2_url                                              
                             
      
      
      
        order.level_test_info   = 'Psihot: ' + psihot_no + ' ___ ' +       
                                  'Pogranich: ' + pogranich_no + ' ___ ' +
                                  'Nevrot: ' + nevrot_no                                   
        
        order.current_test_link = ''    
        order.save      

#__________________________________________      
      
      
      unless order.test_2_ended
        OrderMailer.b_to_test_2_levels(order, link_with_test_2_levels).deliver                          
      end              
      
      order.test_2_ended = true      
      
#__________________________________________        

      if order.level == 'FAIL'
      
        test_2_url_hash = {
          :t => '2',
          :q   => '1',
          :oi    => "#{order_id}",
          :oa  => "#{order_akey}",
          :ps      => '0',
          :po   => '0',
          :ne      => '0'
        }        


        test_2_url_json = JSON.generate(test_2_url_hash)
        test_2_url_encoded_64 = (Base64.encode64 test_2_url_json).chomp.delete("\n")
        test_2_url_encoded = test_2_url_encoded_64 + '=' 
        
        test_2_url = root_path + 'infos/test_proyden_neverno/' + test_2_url_encoded                            
        
        
        
        next_page_after_test_2_level = link_with_test_2_levels = test_2_url                                          
        
        order.test_2_ended = false      
              
      
      end          
#__________________________________________


      order.save

      redirect_to link_with_test_2_levels        
         
    end  #---End Test2
        
#_______________________________________________________________________________        
        
        
    #-else #----- If Not Right Order
    
    #-  #Mail to Admin
      
    #-end #----- Checking is Right Order - Ended       
    
    end #----- TestPart Ended

  end #----- Def Ended
#__________________________________________________________________________________________________________________________________________________


  def qs
    details = params[:details]
    if details == 'alta1175'
      @questions = Question.all
    end
    @main_page = MainPage.new
    @page = Page.first
    @info_msg = OrderInfoPage.find_by(translit: 'dannue_receive_obrabotanu').msg
  end
      
#_______________________________________________________________________________      

  
  
  private
  
    def set_main_page
      @main_page  = MainPage.find(1)       
    end    
    def set_root
      root_path   = MeConstant.find_by_title('root_path').content    
    end
    
    def set_info
      @site_title = MeConstant.find_by_title('site_title').content
      @main_page  = MainPage.find(1)   
      
      @page       = Page.find_by_page :test                
    end      
  
end
