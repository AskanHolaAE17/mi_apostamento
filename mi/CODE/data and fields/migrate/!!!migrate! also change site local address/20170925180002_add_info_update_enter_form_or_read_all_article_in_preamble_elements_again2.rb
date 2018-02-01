class AddInfoUpdateEnterFormOrReadAllArticleInPreambleElementsAgain2 < ActiveRecord::Migration

  

  @element = PreambleElement.find_by name: 'form_or_read_all'

  
  # @element.update body: 'Вы можете <a href="/#form"> пройти тест</a> прямо сейчас или читать подробное описание:'
  
  @element.update body: 'Вы можете __/#form%%пройти тест__ прямо сейчас или читать подробное описание:'  
  


end

