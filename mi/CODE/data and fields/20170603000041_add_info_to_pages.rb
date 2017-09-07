class AddInfoToPages < ActiveRecord::Migration

  

  Page.create page: 'main', title_tag: 'Как сохранить отношения'

  Page.create page: 'test', title_tag: 'Тест', description_meta: 'Прохождение теста', keywords_meta: 'тест, быть в паре', em: 'Тестирование'

  Page.create page: 'more_info_form', title_tag: 'О себе', description_meta: 'Подробная информация о себе', keywords_meta: 'о себе, информация', em: 'конкретная информация'

  Page.create page: 'contacts', title_tag: 'Контакты', description_meta: 'Страница с контактами', keywords_meta: 'контакты людей', em: 'контактная информация людей'

  Page.create page: 'info', title_tag: 'Информация', description_meta: 'Информационное сообщение', keywords_meta: 'информация, прогресс', em: 'Подробности прогресса'

  Page.create page: 'article', title_tag: 'Статья', description_meta: 'читать статью', keywords_meta: 'статья, информация, описание, подобное', em: 'больше подробностей'

  Page.create page: 'room_one', title_tag: 'Комната', description_meta: 'страница пользователя с подробной информацией, личная комната', keywords_meta: 'комната, персональная страница, личная комната', em: 'Описание пользователя, информация, кабинет'

  Page.create page: 'rooms_all', title_tag: 'Комнаты пользователей', description_meta: 'Страница со списком личных комнат пользователей', keywords_meta: 'личные комнаты, список кабинетов', em: 'Кабинеты, комнаты участников'

  Page.create page: 'message_new', title_tag: 'Новое сообщение', description_meta: 'Написать новое сообщение пользователю', keywords_meta: 'сообщение, письмо, новое, отправить', em: 'Общение пользователей, новое письмо, написать сообщение', h2: 'Отправить текст человеку'

  Page.create page: 'messages', title_tag: 'Письмо', description_meta: 'Список входящих и исходящий писем сообщений пользователя', keywords_meta: 'пользователь, участник, письмо, сообщение, комната, кабинет', em: 'Все сообщения в комнате пользователя', h2: 'Все новые и прочитанные письма в кабинете участника'

  Page.create page: 'reco', title_tag: 'Практические рекомендации', description_meta: 'Практические рекомендации о влиянии психологической модели на отношения', keywords_meta: 'практические рекомендации, отношения, модель, психология, пояснения', em: 'Роль психологической модели человека пользователя в построении личных отношений', h2: 'Описание функционирования модели в отношениях людей с помощью практических психологических рекомендаций'

  Page.create page: 'requests', title_tag: 'Запросы', description_meta: 'Страничка с запросами учасников', keywords_meta: 'страница, запросы, пользователи', em: 'все запросы пользователя, входящие и исходящие', h2: 'Одобренные и отклоненные'

  Page.create page: 'conversations', title_tag: 'Собеседники', description_meta: 'Ваши собеседники', keywords_meta: 'общение, страница, собеседники', em: 'общение, люди, переписки, сообщения', h2: 'участники, общаться, пользователи'
 
  

end

