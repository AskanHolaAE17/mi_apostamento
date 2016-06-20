require 'uri'
require 'openssl'
class TestsController < ApplicationController

  before_action :set_main_page, only: [:load_page]
#_____________________________________________________________________________________________________________________________________________

  
  
  def load_page 
    @page       = Page.find_by_page :test
  
    @site_title = MeConstant.find_by_title('site_title').content
      
    root_path   = MeConstant.find_by_title('root_path').content

#_______________________________________

    
    test_url_encoded = params[:test_encrypted]         
    #AES decode    
    #test_url_encoded = test_url_encoded_aes_with_symbols = repl_all_subs('slash', '/', test_url_encoded)
    #    aes_key = 'asdfghjlqwyueuhgkl5'
    #    test_url_encoded = AES.encrypt(test_url_encoded, aes_key)                                                                

    
    test_url_json    = Base64.decode64(test_url_encoded)    
    test_url_hash    = JSON.parse(test_url_json)
    
    test_number = test_url_hash["test_number"].to_i
    qw_number   = test_url_hash["qw_number"].to_i
    @qw_number  = qw_number
    order_id    = test_url_hash["order_id"]
    order_akey  = test_url_hash["order_akey"]
    
#_______________________________________________________________________________        
          
                        
    order = Order.find(order_id)    

    #redirect_to ''


    
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
    
#_______________________________________________________________________________            

    
    if test_number == 1 
      al_no   = test_url_hash['al']
      nl_no   = test_url_hash['nl']
      shl_no  = test_url_hash['shl']
      pl_no   = test_url_hash['pl']
      gml_no  = test_url_hash['gml']
      dl_no   = test_url_hash['dl']
      ml_no   = test_url_hash['ml']
      ol_no   = test_url_hash['ol']
      kl_no   = test_url_hash['kl']
      il_no   = test_url_hash['il']
      disl_no = test_url_hash['disl']
    end  
    
    if test_number == 2 
      psihot_no     = test_url_hash['psihot']
      pogranich_no  = test_url_hash['pogranich']
      nevrot_no     = test_url_hash['nevrot']
    end    
#_______________________________________________________________________________            
    
          
    questions = Test.find_by(number_of_test: test_number).questions.limit(2)      
    questions = questions.where(able: true)
    #.limit(2)      
    
    
    if qw_number < questions.count + 1                                          #----- Start Testing Part
    
      question = questions.find_by_number_of_question(qw_number)
      @question_title = question.title
      
      next_qw_number = (qw_number + 1).to_s
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
        when 'disl' 
          then disl_yes = (disl_no.to_i + 1).to_s
      end      
      
      yes_params_hash = {
        :controller => 'tests', 
        :action => 'load_page',
        :test_number => '1', 
        :qw_number => next_qw_number,
        :order_id => order_id,
        :order_akey => order_akey,
        :al => "#{al_yes or al_no or '0'}",
        :nl => "#{nl_yes or nl_no or '0'}",
        :shl => "#{shl_yes or shl_no or '0'}",
        :pl => "#{pl_yes or pl_no or '0'}",
        :gml => "#{gml_yes or gml_no or '0'}",
        :dl => "#{dl_yes or dl_no or '0'}",
        :ml => "#{ml_yes or ml_no or '0'}",
        :ol => "#{ol_yes or ol_no or '0'}",
        :kl => "#{kl_yes or kl_no or '0'}",
        :il => "#{il_yes or il_no or '0'}",
        :disl => "#{disl_yes or disl_no or '0'}"
      }
    end    

#__________________________________________    


    if test_number == 2
      case question.for_yes_answer_plus_1_point_to
        when 'psihot' 
          then psihot_yes = (psihot_no.to_i + 1).to_s
        when 'pogranich' 
          then pogranich_yes = (pogranich_no.to_i + 1).to_s
        when 'nevrot' 
          then nevrot_yes = (nevrot_no.to_i + 1).to_s
      end      
      
      yes_params_hash = {
        :controller   => 'tests', 
        :action       => 'load_page', 
        :test_number  => '2',
        :qw_number    => next_qw_number,
        :order_id     => order_id,
        :order_akey   => order_akey,
        :psihot       => "#{psihot_yes or psihot_no or '0'}",
        :pogranich    => "#{pogranich_yes or pogranich_no or '0'}",
        :nevrot       => "#{nevrot_yes or nevrot_no or '0'}"
      }    
    end                    
        
#__________________________________________        
        
        
        yes_params_json = JSON.generate(yes_params_hash)
        yes_params_encoded_64 = (Base64.encode64 yes_params_json).chomp.delete("\n")
        yes_params_encoded = yes_params_encoded_64 + '='
        @yes_params = root_path + "test/#{yes_params_encoded}"
#_______________________________________________________________________________
                
         
    if test_number == 1         
      no_params_hash = {
        :controller  => 'tests', 
        :action      => 'load_page', 
        :test_number => '1',
        :qw_number   => next_qw_number,
        :order_id    => order_id,
        :order_akey  => order_akey,
        :al          => "#{al_no or '0'}",
        :nl          => "#{nl_no or '0'}",
        :shl         => "#{shl_no or '0'}",
        :pl          => "#{pl_no or '0'}",
        :gml         => "#{gml_no or '0'}",
        :dl          => "#{dl_no or '0'}",
        :ml          => "#{ml_no or '0'}",
        :ol          => "#{ol_no or '0'}",
        :kl          => "#{kl_no or '0'}",
        :il          => "#{il_no or '0'}",
        :disl        => "#{disl_no or '0'}"
      }
    end            
#__________________________________________            


    if test_number == 2         
      no_params_hash = {
        :controller  => 'tests', 
        :action      => 'load_page', 
        :test_number => '2',
        :qw_number   => next_qw_number,
        :order_id    => order_id,
        :order_akey  => order_akey,
        :psihot      => "#{psihot_no or '0'}",
        :pogranich   => "#{pogranich_no or '0'}",
        :nevrot      => "#{nevrot_no or '0'}"
      }
    end            
#__________________________________________        

        
        no_params_json = JSON.generate(no_params_hash)
        no_params_encoded_64 = (Base64.encode64 no_params_json).chomp.delete("\n")
        no_params_encoded = no_params_encoded_64 + '='
        @no_params = root_path + "test/#{no_params_encoded}"
        
                                      
    else #----- Test ended
#_______________________________________________________________________________
                   

      #-if order and order.akey == order_akey #----- If Right Order                
        
                
      if test_number == 1               
        order.group = if [dl_no.to_i, ml_no.to_i, ol_no.to_i, pl_no.to_i, kl_no.to_i, il_no.to_i, disl_no.to_i].max > [al_no.to_i, nl_no.to_i, shl_no.to_i, gml_no.to_i].max         
          'GOOD GROUP'           
        else                   
          'BAD GROUP'                             
        end
      end  
#__________________________________________        


      if test_number == 2                                                       ### if 2nd Test (233)
      
        l_arr = levels_array    = [psihot_no.to_i, pogranich_no.to_i, nevrot_no.to_i]      # count in every ResultLevelGroups
        max_l = max_level_count = levels_array.max                                         # max count of points

        l_ind = level_indexes   = l_arr.each_index.select{                                 # Indexes of Level(s) with MaxPoints
                                  |i| l_arr[i]== max_l }        
      
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
        
                
        order.group = 'MIDDLE GROUP' if order.level == 'pogranichnick'        
        order.group = 'BAD GROUP' if order.level == 'psihotick'
        
      end                                                                       ### END if 2nd Test (233)

#_______________________________________________________________________________
      

    if test_number == 1                             
      
      
      
        test_2_url_hash = {
          :test_number => '2',
          :qw_number   => '1',
          :order_id    => "#{order_id}",
          :order_akey  => "#{order_akey}",
          :psihot      => '0',
          :pogranich   => '0',
          :nevrot      => '0'
        }        


        test_2_url_json = JSON.generate(test_2_url_hash)
        test_2_url_encoded_64 = (Base64.encode64 test_2_url_json).chomp.delete("\n")
        test_2_url_encoded = test_2_url_encoded_64 + '=' 
        #test_2_url = root_path + 'test/' + test_2_url_encoded
        test_2_url = root_path + 'infos/tekst_mezhdy_testami/' + test_2_url_encoded                            
        
        link_with_test_2_levels = test_2_url                                          
      
      
      
      unless order.test_1_ended
        OrderMailer.b_to_test_2_levels(order, link_with_test_2_levels).deliver                          
      end              
            
                                           
        order.test_1_ended = true
        order.akey         = ''
                
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
                                    'il: ' + il_no + ' ___ ' +                                                                                                                                                                                                                                                                                               
                                    'Disl: ' + disl_no                                                                                                                                                                                                                                                                                                
     
                                          
      order.save
      
      redirect_to link_with_test_2_levels
      
    end  #---End Test1
                          
#__________________________________________




    if test_number == 2             
                             
      
        order.level_test_info = 'Psihot: ' + psihot_no + ' ___ ' +       
                                'Pogranich: ' + pogranich_no + ' ___ ' +
                                'Nevrot: ' + nevrot_no                                   
            
        order.save      
#__________________________________________


      redirect_letter          = ('a'..'z').to_a.shuffle.first
      link_details             = order.id.to_s + redirect_letter + order.akey_payed

      
      link_details_encoded_64  = (Base64.encode64 link_details).chomp.delete("\n")
      link_details_encoded     = link_details_encoded_64 + '=' 

            
      #key_pair  = RSA::KeyPair.generate(1024)
      #link_details_begin_ascii_8 = key_pair.encrypt(link_details_encoded)
      #link_details_begin_for_url = URI.encode(link_details_begin_ascii_8)         
      
            
      
      #link_details_begin_ascii_8 = key_pair.encrypt(link_details_encoded)      
      
      
      
      #link_details_begin = link_details_begin_for_url 
      
      
      #link_with_more_info_form = root_path + 'much_form/' + link_details_begin
      next_page_after_test_2_level = link_with_more_info_form = root_path + 'much_form/' + link_details_encoded                 

#__________________________________________      
      
      
      unless order.test_2_ended
        OrderMailer.c_more_info_form(order, link_with_more_info_form).deliver                  
      end              
      
      order.test_2_ended = true      
      
#__________________________________________        

      if order.level == 'FAIL'
      
        test_2_url_hash = {
          :test_number => '2',
          :qw_number   => '1',
          :order_id    => "#{order_id}",
          :order_akey  => "#{order_akey}",
          :psihot      => '0',
          :pogranich   => '0',
          :nevrot      => '0'
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

      redirect_to next_page_after_test_2_level
         
    end  #---End Test2
        
#_______________________________________________________________________________        
        
        
    #-else #----- If Not Right Order
    
    #-  #Mail to Admin
    #-  redirect_to '/'
      
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
  
  
end
