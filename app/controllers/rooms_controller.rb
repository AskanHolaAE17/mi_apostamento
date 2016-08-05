class RoomsController < ApplicationController


  def create
  end

  def show
  end



  private  
    def user_params
      params.require(:room).permit(:user_id, :id_in_base, :font_size)
    end  

    
end
