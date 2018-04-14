class AddInfoPersonalConsultRequestInOrderInfoPages < ActiveRecord::Migration


  OrderInfoPage.create title: 'Запрос на персональную консультацию отправлен [ personal consult form ]', msg: '<div>
Спасибо. 
<br/>
Ваш запрос на персональную консультацию успешно отправлен.
</div>

<br/>
<div>
Я свяжусь с Вами в течении суток, чтобы мы выбрали удобное время встречи и способ оплаты.
</div>

'


end

