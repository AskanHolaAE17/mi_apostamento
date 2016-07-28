class UsersController < ApplicationController

  def create
  end

  private  
    def user_params
      params.require(:user).permit(:id_in_base, :email, :name, :surname, :group, :akey, :active, :white_writing_able_users_ids_list)
    end  

    
end
