class PersonalConsultsController < ApplicationController


  before_action :set_main_page_and_page, :set_site_title_root,            only: [:index]



  def index
  
  end




  private
  
    def set_main_page_and_page
      @main_page  = MainPage.find(1)      
      @page       = Page.find_by_page :personal_consults   
    end  
       
       
    def set_site_title_root      
      @site_title = MeConstant.find_by_title('site_title').content
      @root_path  = MeConstant.find_by_title('root_path').content      
    end    
    
    
 
end
