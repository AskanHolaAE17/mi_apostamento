require 'uri'
require 'openssl'
class TestLevelsController < ApplicationController


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

      
      if signal_level_arr.count.in? 1..1

        signal_level_arr_not      =  params[:order_signal_level_array] 
        signal_level_arr          = ['ps', 'ne', 'po'].join(' ').sub(signal_level_arr_not[0], '').split(' ')   # leave all (2) STRUCTS but 1 SELECTED
                
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
          last_a['q']     >  cur_a['q']                and 5==3
           
            
        #if  last_a["t"]   == cur_a["t"]                       
          redirect_to root_path + order.current_test_link          
        
        else   #  unless  order.current_test_link  and  last_a["t"]   == cur_a["t"]   
               ## unless last_a["t"]   == cur_a["t"]                       
               
        ##end   # if  last_a["t"]   == cur_a["t"]       
          
      #end   # if  order.current_test_link  and  last_a["t"]   == cur_a["t"]  

#_______________________________________

      
      #if qw_number.to_i == 1
            
      #  if order.current_test_link and cur_answs   # going to REDIRECT to cur test PROGRESS PAGE
                                                   
      #    if order.current_qw_level
      
      
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


      #DEFINE NO count
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


        order.yes_qws_level << ' ' << qw_number.to_s << question.for_yes_answer_plus_1_point_to << '.'   # save cur qw_number to YES order array                 

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
          
          
          #order.current_test_link     = 'testo_more/' + test_2_signal_more_encoded
          
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
          
          
          #order.current_test_link     = 'testo_more/' + test_2_signal_more_encoded
          
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
