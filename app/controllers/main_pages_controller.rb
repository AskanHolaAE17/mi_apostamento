require 'rsa'
require 'uri'
class MainPagesController < ApplicationController

  before_action :set_pages_and_new_order, only: [:index]
#_____________________________________________________________________________________________________________________________________________

  
  #def show_contact_image
  #  @contact = Contact.find(37)
  #  send_data @contact.image, :type => @contact.image_content_type, :disposition => 'inline'    
  #end
  
  
  def index
  
    @site_title             = MeConstant.find_by_title('site_title').content
    
    root_path               = MeConstant.find_by_title('root_path').content      
    @root_path              = root_path
    
    @prerender_page         = root_path                
    
#_______________________________________________________________________________      

    
    @questions = Question.all
    #.shuffle[0..39]
            
#_______________________________________________________________________________      


    translit  = params[:translit]    
    
    if translit
      number  = translit[0].to_i
      
      unless number == 0
        translit[0] = ''
      end      
    end
        
#_______________________________________
        
          
      @articles = if translit == '' or translit == nil
        if number
          Article.where.not(number: number)
        else  
          Article.where.not(code_name: 'main')
        end 
        
      else
        Article.where.not(translit: translit)
      end    
      
      if @articles
        @articles = @articles.order(:number)
      end
    
      ##@articles = @articles.sort! { |a,b| a.login_count <=> b.login_count }
      #@articles = @articles.shuffle
    
#_______________________________________


    @article = Article.where(number: number).first
    unless @article
        
      @article = if translit == '' or translit == nil
        if number and Article.where(number: number).first
          Article.where(number: number).first
        else  
          Article.where(code_name: 'main').first
        end
      else
        if Article.where(translit: translit).first
          Article.where(translit: translit).first
        #@article = Article.where(code_name: 'main').first unless @article
        else
          redirect_to root_path + 'articles/'
          Article.where(code_name: 'main').first          
        end
      end
    
    
      if translit == ''
        @page = Page.find_by(page: 'main')
      end
      
    end      

#________________________________________
    
    
    @preamble_elements    = PreambleElement.order(:number)
    
    @preample_element_select_start_way  = (@preamble_elements.find_by name: 'select_start_way_before_registration').body
    @preamble_element_way               = (@preamble_elements.where name: 'way').first.body.split('<hr/>')
    @preamble_element_form_or_read_all  = (@preamble_elements.where name: 'form_or_read_all').first
    
    article_numbers = '1234'
    article_numbers = article_numbers.delete(@article.number.to_s)
    
    art_num_arr = article_numbers.split('')
    art_num_arr.each do |pre_el|
      @preamble_elements = @preamble_elements.where.not article_number: pre_el
    end

#_______________________________________

    
    @title_tag = @article.title_tag || @page.title_tag || ' '
    
#_______________________________________
    
    
    @page.description_meta = @page.description_meta.to_s
    @page.keywords_meta    = @page.keywords_meta.to_s
    @page.em               = @page.em.to_s
    @page.h2               = @page.h2.to_s
    
    @page.description_meta += @article.description_meta.to_s + ' ' + @page_article.description_meta.to_s
    @page.keywords_meta    += @article.keywords_meta.to_s    + ' ' + @page_article.keywords_meta.to_s
    @page.em               += @article.em.to_s               + ' ' + @page_article.em.to_s
    @page.h2               += @article.h2.to_s
#_______________________________________________________________________________     
    

    # ArticlesMenu in last but one Paragraph in Text  
    descr_full   =  @article.description
    tmp_split    =  descr_full.rindex('<p>')                                    # tmp part: find LAST entry of '<p>' in text                          
    tmp_text     =  descr_full.slice(0, tmp_split)                              # tmp TEXT without last paragraph
    split_symbol =  tmp_text.rindex('<p>') + 3                                  # find LAST BUT ONE split symbol (on original text)     
    last_symbol  =  descr_full.length                                           ## -> split string after this '<p>'
    @descr_start =  descr_full.slice(0, split_symbol)
    @descr_end   =  descr_full.slice(split_symbol + 1, last_symbol)
    
#_______________________________________________________________________________      
    
    
    #link_details_encoded = '123456asdj717866c554731kjnq71n20s78f65q123456asd'
    ##key_pair  = RSA::KeyPair.generate(500)
    ##private_key_params = key_pair.private_key
    ##@result = RSA::Key.initialize()
    #link_details_begin_ascii_8 = key_pair.encrypt(link_details_encoded)
    #@result = URI.encode(link_details_begin_ascii_8)
    
  end
#_____________________________________________________________________________________________________________________________________________  
  
   
  private
  
    def set_pages_and_new_order
      @main_page    = MainPage.find(1)       
      @page         = Page.find_by_page :main
      @page_article = Page.find_by_page :article
      @order        = Order.new      
    end          
    
end
