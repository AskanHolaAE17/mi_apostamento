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
  
  
  #class String
    def xor_with(word, key)
      word.bytes.zip(key.bytes).map { |(a,b)| a ^ b }.pack('c*')
    end
  #end  
  
  
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
