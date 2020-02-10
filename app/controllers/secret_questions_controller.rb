# encoding: utf-8
class SecretQuestionsController < ApplicationController


  def create
  end
  
  

  private  
    def secret_questions_params
      params.require(:secret_question).permit(:body)
    end  
  


end
