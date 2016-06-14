# encoding: utf-8
class ApplicationController < ActionController::Base

  protect_from_forgery with: :null_session
  helper_method :akey, :repl_all_subs, :swap_symb
  
      
  def akey
    key_int = 10.times.map{rand(1..99)}
    key_str = 10.times.map{('a'..'z').to_a[rand(26)]}
    key_int.concat(key_str)
    key_int.shuffle!
    key_int.shuffle!    
    key_int.join  
  end   
  
  
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
