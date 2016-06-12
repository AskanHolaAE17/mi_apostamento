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
    @prerender_page         = root_path                
       
#_______________________________________________________________________________      


    translit  = params[:translit]
    @articles = unless translit
      Article.where.not(code_name: 'main')
    else
      Article.where.not(translit: translit)
    end
    @articles = @articles.shuffle
    
        
    @article = unless translit
      Article.where(code_name: 'main').first
    else
      Article.where(translit: translit).first
    end
    
    
    @page.description_meta += '. ' + @article.description_meta + '. ' + @page_article.description_meta
    @page.keywords_meta    += ', ' + @article.keywords_meta    + ', ' + @page_article.keywords_meta
    @page.em               += ', ' + @article.em               + ', ' + @page_article.em
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
