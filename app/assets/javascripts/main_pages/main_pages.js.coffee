



$ ->
  
  #$('#more_hello').css('display', 'none')
  
  #$('#hello').click ->
  #  $('#more_hello').toggle()
    
  
  #______________________________
    
  # pokazat

  divs_pokazat = $('.pokazat')
  
  
  for pokazat in divs_pokazat
    do ->

      pokazat_ps = pokazat.getElementsByTagName('P')
                  
      pokazat_ps[1].style.display = 'none'
      
      
      node = document.createElement('A')                 
      #node.className = 'pokazat'
      textnode = document.createTextNode('(Развернуть описание)')
      node.appendChild(textnode);                        
      
      pokazat_ps[0].appendChild(node); 

      
      #pokazat_ps[0].getElementByTagName('A').onclick = -> 
      pokazat_ps[0].onclick = -> 
        cur_pokazat_display = pokazat_ps[1].style.display
        pokazat_ps[1].style.display = if cur_pokazat_display == 'none'
          'block'
        else
          'none'        
        
        
        pokazat_as = pokazat_ps[0].getElementsByTagName('A')
        for pokazat_a in pokazat_as
          do ->
          
            pokazat_a_text = pokazat_a.textContent          
            if pokazat_a_text == '(Развернуть описание)'
              pokazat_a.textContent = '(Свернуть описание)'
              
            else if pokazat_a_text == '(Свернуть описание)'
              pokazat_a.textContent = '(Развернуть описание)'  


  
  
  










