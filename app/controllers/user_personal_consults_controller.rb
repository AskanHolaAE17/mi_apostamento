class UserPersonalConsultsController < ApplicationController

  before_action :set_main_page_and_page, :set_site_title_root,            only: [:new]



  def new
    
    @user_personal_consult  = UserPersonalConsult.new
    
  end
  
  
#____________________________________________________________________________________________________________________



  def create   
        
    
    def created_by_human
    
      return true
      
    end
    
    #_____________________________________________________________________________    
    
    
      
    if created_by_human
    
      unless '@'.in?params[:user_personal_consult][:email].to_s or params[:email].to_s.length > 3   # email must be at least: a@a || @aa || aa@
        redirect_to '/personal_consult' 
        
      #_____________________________________________________________________________
      
      
      else   # for:: email must be at least: a@a || @aa || aa@
  
        user_site              = UserSite.new
        user_personal_consult  = user_site.user_personal_consults.build(user_personal_consult_params)     
              
        user_site.email        = user_personal_consult.email    
      
        akey_full = akey
        user_site.akey_short              = akey_full[0..akey_full.length/2]
        akey_full = akey
        user_personal_consult.akey_short  = akey_full[0..akey_full.length/2]
      
        user_site.save
        user_personal_consult.save
    
        ##pendeing:
          # NAME in form (for future emails)
          # [email -> ] TYPE of connection (~checkboxes)
           # with extra text field (+required)
          # DESCR in form      
          ### INCREMENT COOL USER PAY HANDLE BUTTON (story and count  of user_cons, common_sum of user_site) + name 
              
    
        redirect_to '/'  # info page with waiting SOON message from Consulter
  
      end   # for:: email must be at least: a@a || @aa || aa@          
      
    #_____________________________________________________________________________
    
      
    else   # for:: unless 'record is created by Human, not bot'
    
      # EXCEPTION
    
    end   # for:: unless 'record is created by Human, not bot'
          
    
  end



#____________________________________________________________________________________________________________________

    
  
  private  
  
    def user_personal_consult_params
      params.require(:user_personal_consult).permit(:user_site_id, :email, :akey_short, :count_of_consults, :story_of_sessions)
      # params.require(:user_personal_consult).permit(:user_site_id, :email, :name, :akey_short, :count_of_consults, :story_of_sessions, :type_of_connection, :connection_field)
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
