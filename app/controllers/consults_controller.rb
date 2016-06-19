# encoding: utf-8
class ConsultsController < ApplicationController

  def create
    root_path = MeConstant.find_by_title('root_path').content  
    consult = Consult.new(consult_params)      
    
    consult.akey_payed = akey    
    
#_______________________________________________________________________________    

    
    if consult.save
      # PAYING PROCESS    
    
      me_liqpay    = MeLiqpay.find_by_me_number(1)
      public_key   = me_liqpay.public_key
      private_key  = ENV['lp_private_key']
      api_version  = me_liqpay.api_version           
      
      pay_way = MeConstant.find_by_title('pay_via_sandbox').content  
#_______________________________________________________________________________
      
    
      liqpay = Liqpay::Liqpay.new(
        :public_key  => public_key,
        :private_key => private_key
      )    
    
      def encode_json(params)
        JSON.generate(params)
      end    
    
      def encode64(params)
        (Base64.encode64 params).chomp.delete("\n")
      end
#_______________________________________________________________________________


    
      def cnb_form_request(params = {}, liqpay, public_key, api_version)
        params[:public_key] = public_key
        json_params = encode64 encode_json params
        signature = liqpay.cnb_signature params            
        @liqpay_url = "https://liqpay.com/api/#{api_version}/checkout?data=#{json_params.to_s}&signature=#{signature.to_s}"
      end
      
      letter = ('a'..'z').to_a.shuffle.first
      server_url_details  = consult.id.to_s.length.to_s + letter + consult.akey_payed + consult.id.to_s
      
      details_encoded  = (Base64.encode64 server_url_details).chomp.delete("\n")
      server_url_details  = details_encoded
      
      html = cnb_form_request({
        :version          => api_version,
        :action           => 'pay',
        :amount           => consult.sum_for_pay,
        :currency         => 'UAH',
        :description      => "Оплата теста",
        :server_url       => root_path + 'i_have_payed_consult/' + server_url_details,
        :result_url       => root_path + 'info/zakaz_konsyltatsii_oformlen',
        :sandbox          => pay_way        
      }, liqpay, public_key, api_version)                                  
#_______________________________________________________________________________


      consult.pay_link        = @liqpay_url            
      consult.link_if_unsaved = ''
      consult.save    
      
      OrderMailer.e_ready_for_pay_consult(consult).deliver       
      redirect_to html     
      
#_______________________________________________________________________________

          
    else   #if Consult notSave      

      flash[:consult_name]            = consult.name
      #flash[:consult_surname]        = consult.surname
      flash[:consult_email]           = consult.email      
      flash[:consult_payed]           = consult.payed
      flash[:consult_sum_for_pay]     = consult.sum_for_pay
      flash[:consult_selected_time]   = consult.selected_time
      
      flash[:consult_when_payed]      = consult.when_payed
      flash[:consult_akey_payed]      = consult.akey_payed
      flash[:consult_pay_link]        = consult.pay_link
      flash[:consult_able]            = consult.able
                                    
      
      flash[:consult_date1_day]   = consult.date1.strftime("%d %m %Y").split[0]
      flash[:consult_date1_month] = consult.date1.strftime("%d %m %Y").split[1]
      flash[:consult_date1_year]  = consult.date1.strftime("%d %m %Y").split[2]
      
      flash[:consult_date2_day]   = consult.date2.strftime("%d %m %Y").split[0]
      flash[:consult_date2_month] = consult.date2.strftime("%d %m %Y").split[1]
      flash[:consult_date2_year]  = consult.date2.strftime("%d %m %Y").split[2]
            
#_______________________________________________________________________________      
      
      
      anchor = ''
      consult.errors.each do |attr, msg|
        flash[:error_class_name]         = 'error_field' if attr == :name
        #flash[:error_class_surname]      = 'error_field' if attr == :surname
        flash[:error_class_email]        = 'error_field' if attr == :email        
        
        flash[:error_class_date1]    = 'error_field' if attr == :date1
        flash[:error_class_date2]    = 'error_field' if attr == :date2
        flash[:error_class_time1]    = 'error_field' if attr == :time1
        flash[:error_class_time2]    = 'error_field' if attr == :time2        
        
                                        
                
        flash[:autofocus_name]           = false                
        #flash[:autofocus_surname]        = false         
        flash[:autofocus_email]          = false                
                
        flash[:autofocus_date1]      = false                
        flash[:autofocus_date2]      = false         
        flash[:autofocus_time1]      = false                
        flash[:autofocus_time2]      = false                 
        
#_______________________________________________________________________________        
                        
                        
        if attr == :name
          flash[:autofocus_name] = true
        else
        
          #if attr == :surname
          #  flash[:autofocus_surname] = true
          #else
          
            if attr == :email
              flash[:autofocus_email] = true
            else
          
              if attr == :date1
                flash[:autofocus_date1] = true
              else
          
                if attr == :date2
                  flash[:autofocus_date2] = true                
                else
                  if attr == :time1
                    flash[:autofocus_time1] = true                
                  else
                    if attr == :time2
                      flash[:autofocus_time2] = true                
                    end                         
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

            if attr == :email
              anchor = 'email'
            else  
          
              if attr == :date1
                anchor = 'date1'
              else  
            
                if attr == :date2
                  anchor = 'date2'
                else
                  if attr == :time1
                    anchor = 'date1'
                  else
                    if attr == :time2
                      anchor = 'date2'
                    end                                  #attr == :time2
                  end                                  #attr == :time1
                end                                  #attr == :date2
              end                                    #attr == :date1     
            end                                      #attr == :email
          #end                  
        end                                          #attr == :name
        
      end           #consult.errors.each
#_______________________________________________________________________________      
           
                
             
      redirect_to consult.link_if_unsaved
      
    
    end #----end SAVE trying  
    
  end
  
#_____________________________________________________________________________________________________________________________________________

  
  def e_get_consults_after_pay
      
    root_path = MeConstant.find_by_title('root_path').content
    
      
    me_liqpay    = MeLiqpay.find_by_me_number(1)
    public_key   = me_liqpay.public_key
    private_key  = ENV['lp_private_key']
        
    data = params[:data]     
    data_json = Base64.decode64(data)    
    data_hash = JSON.parse(data_json)
    
        
    liqpay = Liqpay::Liqpay.new(
      :public_key  => public_key,
      :private_key => private_key
    )    
    
    sign = liqpay.str_to_sign(
    private_key +
    data +
    private_key
    )       
#_______________________________________________________________________________
  
  
    
    if sign == params[:signature]
      if data_hash["status"].in? ['success', 'sandbox']      
        
        
        
        
        details         = params[:details]  
        
        details_encoded = details
        details         = Base64.decode64(details_encoded)    
        
#_______________________________________________________________________________        

              
        consult_id_length = ''        
        for i in 0..details.length-1
          unless details[i].in? ('a'..'z')
            consult_id_length += "#{details[i]}"  
          else
            break
          end
        end
        consult_id_length = consult_id_length.to_i
    
        consult_id = ''
        for i in (details.length-1-consult_id_length)..(details.length-1)
           consult_id += details[i]
        end        
    
        consult_akey_payed = ''
        for i in (consult_id_length-1)..(details.length-1 - consult_id_length)
           consult_akey_payed += details[i]
        end                    
        
#_______________________________________________________________________________

        
        consult = consult.find(consult_id)      
        #if consult and consult.akey_payed == akey_payed
           
          consult.payed      = true
          consult.akey_payed = ''
          consult.pay_link   = ''
          consult.when_payed = Time.now.utc
        
          unless consult.sent_email_after_pay_for_waiting
            OrderMailer.f_consult_payed(consult).deliver        
            consult.sent_email_after_pay_for_waiting = true
          end  
        
          consult.save        
          
        #else   # if ConsultRecord - not found
          #AdminSecure Email   
        #end  # of: if consult and consult.akey_payed == akey_payed
      end  
    end    
  end


#_____________________________________________________________________________________________________________________________________________



  private
  
    
    def consult_params
      params.require(:consult).permit(:name, :email, :payed, :sum_for_pay, :date1, :time1, :date2, :time2, :selected_time, :when_payed, :akey_payed, :pay_link, :able, :link_if_unsaved, :sent_email_after_pay_for_waiting)
    end  
 

end




