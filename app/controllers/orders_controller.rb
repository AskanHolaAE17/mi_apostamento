# encoding: utf-8
require 'openssl'
require 'uri'
class OrdersController < ApplicationController
  
  
  
  def create
    root_path = MeConstant.find_by_title('root_path').content  

    @order    = Order.find_by email: params[:order][:email]
    
    unless @order
      @order  = Order.new(order_params)
    
      @order.akey       = akey
      @order.akey_payed = akey  
      @order.able       = true    
    end  

#_______________________________________________________________________________


            
    if @order.save
    
    
      @order.name[0] = @order.name[0].upcase    
      #pay+me_liqpay    = MeLiqpay.find_by_me_number(1)
      #pay+public_key   = me_liqpay.public_key
      #pay+private_key  = ENV['lp_private_key']
      #pay+api_version  = me_liqpay.api_version           
      
      #pay+@pay_way = MeConstant.find_by_title('pay_via_sandbox').content  
#_______________________________________________________________________________if @order.save


    
      #pay+liqpay = Liqpay::Liqpay.new(
      #pay+  :public_key  => public_key,
      #pay+  :private_key => private_key
      #pay+)    
    
      def encode_json(params)
        JSON.generate(params)
      end    
    
      def encode64(params)
        (Base64.encode64 params).chomp.delete("\n")
      end
#_______________________________________________________________________________if @order.save


    
      #pay+def cnb_form_request(params = {}, liqpay, public_key, api_version)
      #pay+  params[:public_key] = public_key
      #pay+  json_params = encode64 encode_json params
      #pay+  signature = liqpay.cnb_signature params            
      #pay+  @liqpay_url = "https://liqpay.com/api/#{api_version}/checkout?data=#{json_params.to_s}&signature=#{signature.to_s}"
      #pay+end
#_______________________________________________________________________________if @order.save



      letter = ('a'..'z').to_a.shuffle.first
      server_url_details  = @order.id.to_s.length.to_s + letter + @order.akey + @order.id.to_s
      
      details_encoded_64  = (Base64.encode64 server_url_details).chomp.delete("\n")
      details_encoded     = details_encoded_64 + '=' 
      server_url_details  = details_encoded
      
      #pay+html = cnb_form_request({
      #pay+  :version          => api_version,
      #pay+  :action           => 'pay',
      #pay+  :amount           => @order.sum_for_pay,
      #pay+  :currency         => 'UAH',
      #pay+  :description      => "Оплата теста",flash[:oa]
      #pay+  :server_url       => root_path + 'i_have_payed/' + server_url_details,
      #pay+  :result_url       => root_path + 'info/proverte_email_posle_oplatu',
      #pay+  :sandbox          => @pay_way        
      #pay+}, liqpay, public_key, api_version)                                  
#_______________________________________________________________________________if @order.save



      @order.pay_link = @liqpay_url
      #@order.save

      #pay+OrderMailer.a_has_client_payed(@order).deliver       
      #pay+redirect_to html     


        test_url_hash = {

          #t:  '2',
          #:q  => "#{@order.current_qw_level or '1'}",
          oi: @order.id,
          oa: @order.akey[0..2]
          #:ps => '0',
          #:po => '0',
          #:ne => '0'                  
          
        }        
          #:test_number => '2',
          #:qw_number   => '1',
          #:order_id    => @order.id,
          #:order_akey  => @order.akey,
          #:psihot      => '0',
          #:pogranich   => '0',
          #:nevrot      => '0'         
        
        test_url_json    = JSON.generate(test_url_hash)        
        test_url_encoded_64 = (Base64.encode64 test_url_json).chomp.delete("\n").delete('=')
        
        test_url = root_path + 'testo/' + test_url_encoded_64

#11.1.17#___________________________________________      
      
      
          @order.group = 'GOOD GROUP'   

          @order.level = 'nevrotick'
          level = 'ne'
          
#_______________________________________
        

          current_qw_struct_i = @order.current_qw_struct.to_i
          
          if current_qw_struct_i == 0
            cur_struct_qw        = ((Question.where test: 1).where number_of_question: 1).first          
          end      
          
          if current_qw_struct_i != 0
            cur_struct_qw        = ((Question.where test: 1).where number_of_question: @order.current_qw_struct).first          
          end      
                    
          cur_struct             = cur_struct_qw.for_yes_answer_plus_1_point_to
            
          test_1_start_url_hash  =  {
        
            l:      level,
            t:      '1',
            q:      "#{@order.current_qw_struct or '1'}",        
            oi:     @order.id,
            oa:     @order.akey[0..2],
            cur_s:  cur_struct,          
          
            a:      '0',
            n:      '0',
            s:      '0',
            p:      '0',
            g:      '0',
            d:      '0',
            m:      '0',
            o:      '0',
            #k:      '0',
            i:      '0'
          }        

#_______________________________________


          test_1_start_url_json     =  JSON.generate(test_1_start_url_hash)
          test_1_start_url_encoded  =  (Base64.encode64 test_1_start_url_json).chomp.delete("\n").delete('=')
        
          test_1_start_url          =  root_path                + 
                                      'infos/'                  + 
                                      'tekst_mezhdy_testami/'   + 
                                       test_1_start_url_encoded                                            
      
        test_url = root_path + 'testo_s/' + test_1_start_url_encoded
      
#11.1.17##___________________________________________
        
      
        #order = Order.find(order_id)      
        @order.payed = true
        @order.pay_link = ''
        @order.when_payed = Time.now.utc
        
        unless @order.sent_email_with_test
        
          #unless OrderMailer.b_test_to_client_for_get_contacts_after_cool_pay(@order, test_url).try(:deliver)        
          #  unless OrderMailer.b_test_to_client_for_get_contacts_after_cool_pay(@order, test_url).try(:deliver)        
          #    unless OrderMailer.b_test_to_client_for_get_contacts_after_cool_pay(@order, test_url).try(:deliver)        
          #      redirect_to '/#form'
          #    end            
          #  end          
          #end
                    
          @order.sent_email_with_test = true
        end  
        
        @order.save        
        # order -> local var
#_______________________________________________________________________________
  
  
        
      #else
      #  redirect_to '/'
      #pay+end  
    #else
    #  redirect_to '/'  
    #pay+end     
    
    #pay-   
# test_struct_url_______________________________________________________________________________
#				
    if @order.current_test_link
      redirect_to root_path + @order.current_test_link
    else  
      redirect_to test_url
    end  

#_______________________________________________________________________________if @order.save
       
       
       
    else  
      flash[:order_name]  = @order.name
      flash[:order_email] = @order.email    
      
      
      anchor = ''
      @order.errors.each do |attr, msg|
        flash[:error_class_name]  = 'error_field' if attr == :name
        flash[:error_class_email] = 'error_field' if attr == :email
                
                
        flash[:autofocus_name] = false                
        flash[:autofocus_email] = false     
            
        if attr == :name
          flash[:autofocus_name] = true
        else
          if attr == :email
            flash[:autofocus_email] = true
          end
        end                
                
                
        if attr.in? [:name, :email]
          anchor = '#form'
        end
      end
      
      
      url = root_path +        
            anchor
      redirect_to url 
    end  
  end

#_____________________________________________________________________________________________________________________________________________
  
  
  
  # client ends the PAY PROCESS [SUCCESSFUL]
  # she gets TEST LINK via her email
  # and want to ENTER TEST (and after - get ACCESS to INFO)
            
  def b_test_for_get_contacts_after_pay                
    root_path = MeConstant.find_by_title('root_path').content
    
      
    #pay+me_liqpay    = MeLiqpay.find_by_me_number(1)
    #pay+public_key   = me_liqpay.public_key
    #pay+private_key  = ENV['lp_private_key']
        
    #pay+data = params[:data]     
    #pay+data_json = Base64.decode64(data)    
    #pay+data_hash = JSON.parse(data_json)
    
        
    #pay+liqpay = Liqpay::Liqpay.new(
    #pay+  :public_key  => public_key,
    #pay+  :private_key => private_key
    #pay+)    
    
    #pay+sign = liqpay.str_to_sign(
    #pay+private_key +
    #pay+data +
    #pay+private_key
    #pay+)       
#_______________________________________________________________________________
  
  
    
    #pay+if sign == params[:signature]
      #pay+if data_hash["status"].in? ['success', 'sandbox']      
        
        
        
        
        details         = params[:details]  
        
        details_encoded = details
        details_encoded[details_encoded.length-1] = ''
        details         = Base64.decode64(details_encoded)    
        
        
        
        order_id_length = ''        
        for i in 0..details.length-1
          unless details[i].in? ('a'..'z')
            order_id_length += details[i]
          else
            break
          end
        end
        order_id_length = order_id_length.to_i
    
        order_id = ''
        for i in (details.length-order_id_length)..(details.length-1)
           order_id += details[i]
        end        
    
        order_akey = ''
        for i in (order_id_length-1)..(details.length-1 - order_id_length)
           order_akey += details[i]
        end                    
#______________________________________
        
        
        test_url_hash = {
          :t  => '2',
          :q  => '1',
          :oi => @order.id,
          :oa => @order.akey,
          :ps => '0',
          :po => '0',
          :ne => '0'
          
          #:test_number => '2',
          #:qw_number   => '1',
          #:order_id    => @order.id,
          #:order_akey  => @order.akey,
          #:psihot      => '0',
          #:pogranich   => '0',
          #:nevrot      => '0'                              
        }        
          
        test_url_json = JSON.generate(test_url_hash)
        test_url_encoded_64 = (Base64.encode64 test_url_json).chomp.delete("\n")
        test_url_encoded = test_url_encoded_64 + '=' 
        test_url = root_path + 'test/' + test_url_encoded              
        
#______________________________________        
        
 
        order = Order.find(order_id)      
        order.payed = true
        order.pay_link = ''
        order.when_payed = Time.now.utc
        
        unless order.sent_email_with_test
          #OrderMailer.b_test_to_client_for_get_contacts_after_cool_pay(order, test_url).deliver        
          order.sent_email_with_test = true
        end  
        
        order.save        
#_______________________________________________________________________________
  
  
        
      #else
      #  redirect_to '/'
      #pay+end  
    #else
    #  redirect_to '/'  
    #pay+end     
    
        
    #pay-
    redirect_to test_url
  end    
#_____________________________________________________________________________________________________________________________________________    

    
  
  private  
    def order_params
      params.require(:order).permit(:payed, :name, :email, :akey, :pay_link, :sum_for_pay, :when_payed, :akey_payed, :able, :sent_email_with_test, :group, :structure_test_info, :level, :test_1_ended, :test_2_ended, :level_test_info, :contact_id, :structure)
    end  

end    
  
