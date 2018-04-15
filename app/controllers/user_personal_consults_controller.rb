class UserPersonalConsultsController < ApplicationController

  before_action :set_main_page_and_page, :set_site_title_root,            only: [:new]



  def new
    
    @user_personal_consult  = UserPersonalConsult.new
    
    
    flash[:time_prev] = Time.now    
    
  end
  
  
#____________________________________________________________________________________________________________________



  def create   
                
    
    time_prev = flash[:time_prev].to_time             # form loaded     at
    time_next = Time.now.to_time                      # form processed  at
    
    waiting_time = (time_next - time_prev).round      # in seconds
    
    # flash[:error] = " #{time_prev}  and  #{time_next}  is  #{waiting_time} sec"
    
    
    def created_by_human(waiting_time)
    
      if waiting_time >= 1   # count of seconds between PageEndedLoading and FormIsSended
        true
      else        
        false
      end  
      
    end
    
    #_____________________________________________________________________________    
    
    
    user_site              = UserSite.new
    user_personal_consult  = user_site.user_personal_consults.build(user_personal_consult_params)     
              
    user_site.email        = user_personal_consult.email    
      
    akey_full = akey
    user_site.akey_short              = akey_full[0..akey_full.length/2]
    akey_full = akey
    user_personal_consult.akey_short  = akey_full[0..akey_full.length/2]
      
    # user_personal_consult.story_of_sessions = 'Zero consult time: ' + params[:user_personal_consult][:story_of_sessions].to_s + ', '   # to! timezone +3      
    
     
    #_____________________________________________________________________________          
   
      
    if created_by_human(waiting_time)
    
      unless '@'.in?params[:user_personal_consult][:email].to_s or params[:email].to_s.length > 3   # email must be at least: a@a || @aa || aa@
      
        # SAVING THE DATA FROM FORM FIELDS
      
        redirect_to '/personal_consult'         
        
      #_____________________________________________________________________________
      
      
      else   # for:: email must be at least: a@a || @aa || aa@
  
      
        user_site.save
        user_personal_consult.save
        @user_personal_consult = user_personal_consult
    
        ##pendeing:
          # NAME in form (for future emails)
          # [email -> ] TYPE of connection (~checkboxes)
           # with extra text field (+required)
          # DESCR in form      
          ### INCREMENT COOL USER PAY HANDLE BUTTON (story and count  of user_cons, common_sum of user_site) + name 
              
    
        UserPersonalConsultMailer.b_mail_to_consult_for_first_connection(@user_personal_consult).try(:deliver)
        
        redirect_to '/info/zapros_na_personalnyyu_konsyltatsiyu_otpravlen__personal_consult_form' 
  
      end   # for:: email must be at least: a@a || @aa || aa@          
      
    #_____________________________________________________________________________
    
      
    else   # for:: unless 'record is created by Human, not bot'
    
      user_site.active = false
      
      user_site.save
      user_personal_consult.save
            
      the_story_of_sessions   = "___ StoryOfSessions:   #{user_personal_consult.story_of_sessions}   "    if user_personal_consult.story_of_sessions != ''
      the_type_of_connection  = "___ TypeOfConnection:   #{user_personal_consult.type_of_connection}   "  if user_personal_consult.type_of_connection
      the_connection_address  = "___ ConnectionAddress:   #{user_personal_consult.connection_address} "   if user_personal_consult.connection_address
      
      error_description   = " UserGlobal id: #{user_site.id} ___   
 PersonalConsult id:   #{user_personal_consult.id} ___   
 Email:   #{user_personal_consult.email} "     +
                              the_story_of_sessions.to_s   +
                              the_type_of_connection.to_s  +
                              the_connection_address.to_s
                          
      error_live = ErrorLive.new( error_title: 'PersonalConsult Request is created by bot', 
                                  error_description: error_description, 
                                  error_code: 101)                                                                                                  
      error_live.save
      error_live.error_number = error_live.id
      error_live.save
      
      SecureMailer.personal_consult_first_request_is_created_by_bot(user_personal_consult, error_live).try(:deliver)
      
      
      # REDIRECT TO DEADLOCK (page)
      flash[:deadlock] = 'deadlock'
      
      redirect_to '/info/zapros_na_personalnyyu_konsyltatsiyu_otpravlen__personal_consult_form'   
    
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
