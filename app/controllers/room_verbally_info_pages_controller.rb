# encoding: utf-8
class RoomVerballyInfoPagesController < ApplicationController

  before_action :set_pages_and_room_verbally_info_page, :set_site_title,  only: [:show]

  def show
    @root_path    = MeConstant.find_by_title('root_path').content      
  end
#_____________________________________________________________________________________________________________________________________________

  
    
  private
  
    
    def set_pages_and_room_verbally_info_page
      @page       = Page.find_by_page :info
      @main_page  = MainPage.find(1)       
  
      msg         = params[:msg]    
      @info_msg   = (RoomVerballyInfoPage.find_by translit: msg).msg
    end  
    
    
    def set_site_title 
      @site_title = MeConstant.find_by_title('site_title').content          
    end                                                 
    
end
