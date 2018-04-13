class UserPersonalConsultsController < ApplicationController

  before_action :set_main_page_and_page, :set_site_title_root,            only: [:new]



  def new
    
    @user_personal_consult  = UserPersonalConsult.new
    
  end
  
  
  
  def create
  
    
  
  end



#_____________________________________________________________________________________________________________________________________________    

    
  
  private  
  
    def user_personal_consult_params
      params.require(:user_personal_consult).permit(:user_site_id, :email, :name, :akey_short, :count_of_consults, :story_of_sessions)
    end  
  
    def set_main_page_and_page
      @main_page  = MainPage.find(1)      
      @page       = Page.find_by_page :personal_consults   
    end  
       
       
    def set_site_title_root      
      @site_title = MeConstant.find_by_title('site_title').content
      @root_path  = MeConstant.find_by_title('root_path').content      
    end    
    
    
 
end
