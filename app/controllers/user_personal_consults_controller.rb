class UserPersonalConsultsController < ApplicationController

  before_action :set_main_page_and_page, :set_site_title_root,            only: [:new]



  def new
    
    @user_personal_consult  = UserPersonalConsult.new
    
  end
  
  
  
  def create
  
    user_personal_consult = UserPersonalConsult.new(user_personal_consult_params)   
    
    # NAME in form (for future emails)
    # [email -> ] TYPE of connection (~checkboxes)
    ## with extra text field (+required)
    # DESCR in form
    
    
    # user_cons edit (akey_short)
        
    # user_site < user_personal
    # user_site edit (email, akey_short)   
    
    # user_personal_consult.save
    # user_site.save
    
    
    ### INCREMENT COOL USER PAY HANDLE BUTTON (story and count  of user_cons, common_sum of user_site) + name    
    
    redirect_to '/'  # info page with waiting SOON message from Consulter
  
  end



#_____________________________________________________________________________________________________________________________________________    

    
  
  private  
  
    def user_personal_consult_params
      params.require(:user_personal_consult).permit(:user_site_id, :email, :name, :akey_short, :count_of_consults, :story_of_sessions, :type_of_connection, :connection_field)
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
