class AddInfoSelectStartWayInPreambleElementsAgain5 < ActiveRecord::Migration

  

  @element = PreambleElement.find_by name: 'select_start_way_before_registration'
  
  @element.update body: '
      <h3>Приветствуем Вас!</h3>
      <h4>Выберите вопрос, на который Вы хотите найти ответ:</h4>
      <div id="site_motto"><br/>



      <hr/>find_your_pair Как с нашей помощью разобраться, какой партнер Вам подходит,
      чтобы найти свою любовь среди ближайшего окружения или среди тысяч других людей на сайтах знакомств?
      <br/>
      <br/>
    


      <hr/>improve_relation Как сделать отношения с партнером счастливыми?
      <br/>
      <br/>  



      <hr/>self_understanding Как разобраться в своей психологической модели?
      <br/>
      <br/>  



      <hr/>test_someone Или же как протестировать психологическую модель ребенка, подростка, коллеги, подчиненного?
      <br/>
      <br/>



      <hr/>

      </div>'  
  


end

