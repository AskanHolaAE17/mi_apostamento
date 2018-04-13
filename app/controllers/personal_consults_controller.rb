class PersonalConsultsController < ApplicationController


  before_action :set_main_page_and_page, :set_site_title_root,            only: [:index]



  def index
  
    @personal_consult  = PersonalConsult.new(personal_consult_params)
    
  end



#_____________________________________________________________________________________________________________________________________________    

    
  
  private  
  
    def personal_consult_params
      params.require(:personal_consult).permit(:payed, :name, :email, :akey, :pay_link, :sum_for_pay, :when_payed, :akey_payed, :able, :sent_email_with_test, :group, :structure_test_info, :level, :test_1_ended, :test_2_ended, :level_test_info, :contact_id, :structure)
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
