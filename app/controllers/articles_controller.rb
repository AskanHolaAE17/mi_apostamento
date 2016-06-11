# encoding: utf-8
class ArticlesController < ApplicationController



  private  
    def article_params
      params.require(:article).permit(:title, :description, :image, :code_name, :able)
    end                

end
