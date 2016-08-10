# encoding: utf-8
class ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session
  helper_method :akey, :repl_all_subs, :swap_symb, :id_in_base, :xor_with
  
      
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
  
  
  def id_in_base(devided_by)    # without Id in begin of string
    iibase = akey + akey          #id_in_base
    iibase = iibase.gsub(/\D+/, '')
    iibase = iibase.slice(0, iibase.length/devided_by.to_i)  
    iibase = iibase.to_s
  end    

#_______________________________________________________________________________
  

  def details_from_url_to_array(details)
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
    puts res_array[0]
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

  
end
