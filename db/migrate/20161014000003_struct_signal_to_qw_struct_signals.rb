class StructSignalToQwStructSignals < ActiveRecord::Migration


Question.all.where(test_id: '1').destroy_all
  
  
  

QwStructSignal.create title: 'Мой партнер часто заставлял меня испытывать страдания, но я не уходил от него. Я знал, что если я покажу, что я уже страдаю, то он воздержится от дополнительных нападок на меня. То, что я страдаю, дает мне право на хорошее ко мне отношение, утешение, заботу обо мне.  Страдание и терпение вознаграждаются. Мои терпение и самопожертвование должны убедить обидчиков, что они жестокие и морально низкие. Для того чтоб чувствовать себя лучше, я нуждаюсь в сочувствии и внимании.  Я бываю разочарован, когда близкие наслаждаются жизнью и хорошо себя чувствуют, если  мне плохо.', 
                for_yes_answer_plus_1_point_to: 'ml', 
                number_of_question: '1',
                test_id: '1'

QwStructSignal.create title: 'Люди по своей природе- хищники и стремятся использовать других для  достижения  своих личных целей, подчиняя своей власти. Я никогда не допускаю, чтоб на меня накладывали ограничения, использовали меня. Наоборот, это я подчиняю своему влиянию силе.  Оказывать давление, демонстрировать свою силу - признак сильного человека. Я уважаю только силу. Вместо того, чтобы говорить, я действую. А слова нужны, только чтоб контролировать других.', 
                for_yes_answer_plus_1_point_to: 'al', 
                number_of_question: '2',
                test_id: '1'
                
QwStructSignal.create title: 'Я всегда слежу за враждебными мотивами других людей и направляю свои усилия на провал их угрожающих мне замыслов. Я стараюсь распознать в поведении других их злые намерения в отношении меня, так как все, что происходит вокруг, имеет прямое отношение к моей личности. Моё самоуважение повышается в борьбе против несправедливости и против врагов.', 
                for_yes_answer_plus_1_point_to: 'pl', 
                number_of_question: '3',
                test_id: '1'
                
QwStructSignal.create title: 'Я внимательно слежу за тем, насколько моя жизнь соответствует в глазах других самым высоким стандартам престижности и идеальному имиджу успешного человека, чтоб окружающие  видели и признавали мое превосходство.  Это дает мне чувство превосходства и избавляет от ощущения внутренней пустоты.  Мне важно постоянно заново убеждаться в моей привлекательности, известности, престижности и значимости для других в моем совершенстве. Я хочу вызывать восхищение, похвалу, даже зависть, хочу, чтоб  мою жизнь считали идеальной.', 
                for_yes_answer_plus_1_point_to: 'nl', 
                number_of_question: '4',
                test_id: '1'
                
QwStructSignal.create title: 'Я ищу близости и привязанности. Без отношений я чувствую себя потерянным. Я страдаю, тоскую и печалюсь по утраченным отношениям, виню и упрекаю себя, что недостаточно ценил и заботился о партнере, что и привело к разрыву. Я недостаточно хорош, чтоб вдохновить привязанность и пробудить к себе любовь. Это мои плохие человеческие качества привели к потере любви. Улучшая свои внутренние качества, я смогу сохранять отношения. Я терпелив к недостаткам партнера, критикую себя и злюсь на себя, а не на него. Я часто уступаю из-за страха неодобрения.', 
                for_yes_answer_plus_1_point_to: 'dl', 
                number_of_question: '5',
                test_id: '1'

QwStructSignal.create title: 'Я хорошо понимаю свои чувства и чувства других, но я свои чувства никогда не показываю и не выражаю. Я не могу ни состоять в отношениях, ни жить вне отношений. Отношения кажутся мне западней.  Я не всегда признаю настоящее глубинное, эмоциональное значение для меня  какого-то события или отношений, и что эти чувства для меня на самом деле означают. Я просто  отрезаю себя от своих чувств к людям. Но это заблуждение, что я бесчувственный.', 
                for_yes_answer_plus_1_point_to: 'shl', 
                number_of_question: '6',
                test_id: '1'
                
QwStructSignal.create title: 'У меня есть четкая необходимость в постоянной, интенсивной, активной деятельности. Я готов  работать, бесконечно выполняя задания, обязательства, опираясь на свою силу воли.  Я получаю чувство удовлетворения от исполненного долга, от того, что я оправдываю ожидания родственников или руководства.Я постоянно прикладываю усилия, что-то делаю, мобилизую свои силы. Моя жизнь вращается вокруг работы, это основная часть моей жизни. Я как машина. Я отвлекаю себя от глубоких сложных чувств печали, тоски  с помощью определенных способов: беспрестанно прокручиваю в голове множество своих дел, выполняю рутинные дела, чтоб сохранить твердость духа, и превращаю негативные эмоции в энергичную деятельность, стараясь делать что-то полезное.', 
                for_yes_answer_plus_1_point_to: 'kl', 
                number_of_question: '7',
                test_id: '1'
                
QwStructSignal.create title: 'Мне не хватает мужества вести себя с большим самоутверждением, чем это позволяли мне в детстве: иметь и демонстрировать свои амбиции, создавать новую степень близости в личных отношениях, принять на себя зрелую ответственность за свою жизнь. Иногда, чтобы обезоружить потенциального обидчика и людей, которых я опасаюсь,  я становлюсь ребячливой и беспомощной, слабой и благодарной или очаровываю их. Когда моя тревога становится слишком сильной, то я ищу облегчения в любовной истории с сильным мужчиной, или заболеваю, или веду себя по-детски, ребячливо, словно ощущаю себя маленьким, пугливым ребенком.', 
                for_yes_answer_plus_1_point_to: 'il', 
                number_of_question: '8',
                test_id: '1'
                
QwStructSignal.create title: 'Все важные отношения в моей жизни были внезапно прерваны по моей инициативе.  Я об этом не жалею, не грущу, мне ничего не жаль. Я опасаюсь привязанности, потому что забота о ком-то означает, что потеря этих отношений будет для меня невыносимой и опустошающей душу болью. Я заводной и веселый, как детская игрушка «волчок»,  я всегда в приподнятом настроении. Я часто чувствую себя неуязвимым, убежденным в успехе своих грандиозных планов. Я не могу замедлиться. Я не умею грустить.', 
                for_yes_answer_plus_1_point_to: 'gml', 
                number_of_question: '9',
                test_id: '1'
                                
QwStructSignal.create title: 'Самоограничения, целеустремленность, соблюдение правил и дисциплины, самоконтроль в выражении эмоций- мои основные качества. Я сам предъявляю к себе высокие требования. Для меня большую ценность представляет моя мыслительная деятельность. Принимая решение, я стараюсь обосновать его логикой и разумной рациональностью, моральными и нравственными принципами. Именно рациональность избавляет меня от сомнений и чувства вины. Я живу в состоянии постоянного усилия, самоконтроля и волевого напряжения человека, которому нужно закончить работу в срок. Это ощущение меня никогда не покидает. Мне иногда кажется, что позади меня сидит надсмотрщик, который мне отдает приказы, напоминает, подгоняет. Я не показываю свою злость и не ослабляю самоконтроль.', 
                for_yes_answer_plus_1_point_to: 'ol', 
                number_of_question: '10',
                test_id: '1'
                
                
end

