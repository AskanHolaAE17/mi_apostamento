class UploadStructures70ToQuestions < ActiveRecord::Migration


Question.all.where(test_id: '1').destroy_all

  
  
Question.create title: 'Иногда я просто чувствую себя обязанным критиковать и наказывать своих детей или подчиненных из лучших побуждений к ним. Я бываю просто  обязан так поступать. Это мой долг, и в этом мои моральные обязательства перед ними. ', test_id: '1', for_yes_answer_plus_1_point_to: 'ml'
Question.create title: 'Мое самоуважение растет, когда я могу проявлять своё влияние на других и использовать свою власть над людьми. Ничего плохого нет в том, чтоб при необходимости «перешагивать» через других людей.', test_id: '1', for_yes_answer_plus_1_point_to: 'al'
Question.create title: 'Я беспокоюсь, что мои переживания фундаментально отличаются от переживаний других людей. Мне страшно, что значимые для меня близкие люди, узнав мой внутренний мир, эмоционально отдалятся от меня. И в то же время я боюсь потерять себя в отношениях. Это заблуждение, что я бесчувственный.', test_id: '1', for_yes_answer_plus_1_point_to: 'shl'
Question.create title: 'Я отвлекаю себя от глубоких сложных чувств печали, тоски  с помощью определенных способов: беспрестанно прокручиваю в голове множество своих дел, выполняю рутинные дела или ритуалы, чтоб сохранить твердость духа, и превращаю негативные эмоции в энергичную деятельность. Не даю  себе отдыха и расслабления, перегружая себя.', test_id: '1', for_yes_answer_plus_1_point_to: 'kl'
Question.create title: 'В детстве я никогда не чувствовал полной физической и эмоциональной безопасности, защищенности и поддержки. Меня критиковали, наказывали, и я не мог понять - почему. Взрослые меня не поддерживали, не утешали и не объясняли сути происходящего.', test_id: '1', for_yes_answer_plus_1_point_to: 'pl'
Question.create title: 'Мне невыносимо знать о моих недостатках. Для меня очень важно, чтоб меня одобряли, хвалили, восхищались, потому что от этого повышается мое самоуважение. Я должен быть уверен, что моя девушка (парень) идеальна. Если в ней есть недостатки, то мы расстанемся.', test_id: '1', for_yes_answer_plus_1_point_to: 'nl'
Question.create title: 'Я остро осознаю свою потребность находиться в постоянном движении, не оставаться в одиночестве, избегая при этом эмоциональной привязанности. Свои негативные эмоции я проявляю в виде гнева, а не грусти. Затем я испытываю вину. Я не знаю, что такое безмятежность, грусть, печаль.', test_id: '1', for_yes_answer_plus_1_point_to: 'gml'
Question.create title: 'Меня глубоко ранит потеря любви и отношений. Я долго тоскую и печалюсь по утраченным отношениям, виню себя, что недостаточно ценил и заботился о партнере, что и привело к разрыву. Я не верю в свою ценность для других. Мне трудно почувствовать удовлетворение от своих успехов.', test_id: '1', for_yes_answer_plus_1_point_to: 'dl'
Question.create title: 'Я  не всегда знаю, какие чувства у меня вызывают люди и ситуации, и что эти чувства для меня по-настоящему означают.  Также я часто не могу описать, что я чувствую к человеку, а описываю его отдельные черты и качества. Я часто не умею уловить настроение другого человека, его суть и неповторимость. Пока другие бурно выражают эмоции,  я сдерживаю себя в проявлении чувств, стараясь делать вместо этого что-то полезное. Мне трудно выражать свою нежность, быть теплым ласковым,я бываю как деревянный.', test_id: '1', for_yes_answer_plus_1_point_to: 'ol'
Question.create title: 'Я использую секс скорее как защиту, а не как самовыражение. Я боюсь старения и обеспокоен признаками возраста. Бывает, что я соблазняю для того, чтоб удостовериться в своей привлекательности.', test_id: '1', for_yes_answer_plus_1_point_to: 'il'



Question.create title: 'Я часто испытываю  чувство стыда, обманутости,  несоответствия, нелюбимости, и что «я не подхожу». Мое самоуважение очень зависит от того, как меня воспринимают окружающие, и какое впечатление я произвожу на них. Я очень чутко реагирую на оценки окружающих. Я хорошо себя чувствую, только если окружающие ставят мне оценку «отлично».', test_id: '1', for_yes_answer_plus_1_point_to: 'nl'
Question.create title: 'У меня есть дар - я всегда знаю уязвимые места других. Поэтому я с легкость оказываю свое влияние на людей, надавливая на их уязвимые места.', test_id: '1', for_yes_answer_plus_1_point_to: 'al'
Question.create title: 'Я хорошо понимаю свои чувства и чувства других, но я свои чувства не показываю и не выражаю. Я не могу ни состоять в отношениях, ни жить вне отношений. Я отрезаю себя от своих чувств, чтоб не переживать. Такая отстраненность снижает тревогу.', test_id: '1', for_yes_answer_plus_1_point_to: 'shl'
Question.create title: 'Я часто перевожу в юмор любые серьезные замечания в мой адрес или негативные события, которые расстроили бы или встревожили большинство других людей. Мне очень трудно выдерживать печаль. Я хочу научиться не опасаться, что я не перенесу печаль в случае расставания.', test_id: '1', for_yes_answer_plus_1_point_to: 'gml'
Question.create title: 'Я всегда напоминаю себе, что я должен соответствовать своей профессиональной, супружеской или родительской роли. Это очень важные для меня роли. Я получаю чувство удовлетворения от исполненного долга, от того, что я оправдываю ожидания родственников или руководства.', test_id: '1', for_yes_answer_plus_1_point_to: 'kl'
Question.create title: 'Я живу с ощущением нелюбви к себе, собственной плохости, своего внутреннего несовершенства и вины, собственной неинтересности, малоценности, безнадежности, поэтому я не верю, когда меня хвалят. В глубине своей я плохой, недостойный, некомпетентный, ошибающийся.', test_id: '1', for_yes_answer_plus_1_point_to: 'dl'
Question.create title: 'Во всех происходящих вокруг событиях я вижу попытки навредить лично мне и враждебность ко мне. Я испытываю страх физического повреждения и морального уничтожения, унижения, поэтому стремлюсь контролировать других людей.', test_id: '1', for_yes_answer_plus_1_point_to: 'pl'
Question.create title: 'Я великодушен к тем людям, кто меня обижает и заставляет страдать, я их прощаю и забочусь о них.  Моё терпение должно убедить людей, что они жестоки.  Главное — это моральная победа над обидчиками. Мой способ борьбы с моими обидчиками — показать, что они морально низкие личности, агрессивные, жестокие и эгоистичные. ', test_id: '1', for_yes_answer_plus_1_point_to: 'ml'
Question.create title: 'Я считаю, что не думать о деле- это безрассудство. Я не понимаю, как можно найти удовлетворение в жизни, если нет постоянной цели, отсутствуют усилия и стремление улучшить карьеру, заработать денег. Для меня большую ценность представляет моя мыслительная деятельность. Я могу работать над задачей день и ночь, заставляю себя об этом думать, не могу расслабиться, составляю списки аргументов за и против.  Самоограничения, целеустремленность, требовательность к себе и самоконтроль в выражении эмоций- мои основные качества.', test_id: '1', for_yes_answer_plus_1_point_to: 'ol'
Question.create title: 'Люди моего пола часто бывают беспомощны и незначительны, а люди противоположного пола обладают властью и силой - иногда они опасны. Мне часто навязывают роль слабого человека, который нуждается в советах,  из-за моей половой принадлежности, так как у мужского и женского пола не одинаковая ценность.', test_id: '1', for_yes_answer_plus_1_point_to: 'il'



Question.create title: 'Я всегда слежу за тем, чтоб соответствовать статусности, престижности, высоким стандартам жизни, имиджу успешного человека. Без этого моя самооценка резко падает. Неудача или чье-то неодобрение полностью выбивают меня из колеи. Ведь я хочу получать только высокие оценки окружающих.', test_id: '1', for_yes_answer_plus_1_point_to: 'nl'
Question.create title: 'Я часто ожидаю, что окружающие хотят чувствовать свое превосходство надо мной и подчеркивать мои недостатки. Поэтому я стремлюсь поразить их своей враждебностью и критикой, безжалостно фиксируя на них свой взгляд.', test_id: '1', for_yes_answer_plus_1_point_to: 'pl'
Question.create title: 'Я всегда готов поверить в самое худшее о самом себе. Я слышу только ту часть сообщения, где говорят о моих недостатках, ошибках, и не слышу любые хвалебные отзывы в мой адрес. Мне трудно противостоять оскорблениям.  Я приписываю удачи другим, а неудачи себе. Мои заслуги ничего не стоят, я всегда ожидаю критики и порицания. Я часто уступаю из-за страха неодобрения. ', test_id: '1', for_yes_answer_plus_1_point_to: 'dl'
Question.create title: 'Мне трудно поверить в то, что если я раскрою свои чувства, то меня не будут высмеивать или подчинять. Поэтому я самовыражаюсь в творчестве (науке, технике). Тут я получаю самую большую психологическую безопасность и удовлетворение, когда стремлюсь к уникальности, оригинальности, креативности в своей творческой деятельности.', test_id: '1', for_yes_answer_plus_1_point_to: 'shl'
Question.create title: 'Если есть риск разрыва важных для меня личных отношений из-за отсутствия доверия к партнеру, то я их сразу же прерываю, пока потеря отношений не стала для меня слишком болезненной. И вообще, я опасаюсь привязанности, потому что забота о ком-то означает, что потеря этих отношений будет для меня невыносимой и опустошающей душу. ', test_id: '1', for_yes_answer_plus_1_point_to: 'gml'
Question.create title: 'У меня склонность к несчастным случаям и самоповреждениям. Единственная причина, по которой со мной случалось что-то хорошее, - это то, что я достаточно пострадал.  Тогда меня утешали, давая мне внимание. Если я покажу, что я уже страдаю, то партнер воздержится от дополнительных нападок на меня.', test_id: '1', for_yes_answer_plus_1_point_to: 'ml'
Question.create title: 'Моё самоуважение повышается, когда мне удается использовать потенциал своей сексуальной привлекательности. Это дает мне ощущение того, что я обладаю таким же статусом и силой, как и люди противоположного пола.', test_id: '1', for_yes_answer_plus_1_point_to: 'il'
Question.create title: 'Я усиленно стараюсь найти правильное решение, стараюсь обосновать его логикой и разумной рациональностью, моральными и нравственными принципами. Именно рациональность избавляет меня от сомнений и чувства вины, ведь я очень чутко настроен на то, как другие отнесутся к моему решению, не будут ли критиковать. Но иногда мне не достает убежденности. ', test_id: '1', for_yes_answer_plus_1_point_to: 'ol'
Question.create title: 'Я никогда не допускаю, чтоб на меня накладывали ограничения, использовали меня. Наоборот, это я подчиняю своему влиянию силе. В детстве у меня всегда получалось делать все, что я хотел, и при этом я умел избежать наказания. Я до сих пор стремлюсь к острым ощущениям.', test_id: '1', for_yes_answer_plus_1_point_to: 'al'
Question.create title: 'Иногда у меня возникает страх сойти с ума из-за чувства потери контроля. Этот страх возникает,  когда что-то нарушает мою обычную решимость или когда я поддаюсь искушению, теряю хладнокровие. Такое временное подчинение импульсу или прихоти для меня неприятно. Неустанным движением к цели я контролирую себя и свою жизнь. Я как машина.', test_id: '1', for_yes_answer_plus_1_point_to: 'kl'



Question.create title: 'У меня есть четкая необходимость в постоянной, интенсивной, активной деятельности. Я готов  работать, бесконечно выполняя задания, обязательства, опираясь на свою силу воли. Я постоянно прикладываю усилия, что-то делаю, мобилизую свои силы, сам оказываю на себя давление. Моя жизнь вращается вокруг работы, это основная часть моей жизни. ', test_id: '1', for_yes_answer_plus_1_point_to: 'kl'
Question.create title: 'У меня в жизни не было неудач. Ошибки должны быть редкими, они заслуживают строгого порицания. Когда меня не хвалят, я воспринимаю это как критику и провал. Я рад симпатизирующему и подбадривающему отношению ко мне - это на время заполняет мое чувство внутренней пустоты и личной несостоятельности.', test_id: '1', for_yes_answer_plus_1_point_to: 'nl'
Question.create title: 'Оказывать давление, демонстрировать свою силу - признак сильного человека. Я уважаю только силу. Вместо того, чтобы говорить, я действую. А слова нужны, только чтоб контролировать других.', test_id: '1', for_yes_answer_plus_1_point_to: 'al'
Question.create title: 'С одной стороны, я хочу, чтоб люди, которые мне небезразличны, узнали меня как можно полнее. Но с другой стороны, я опасаюсь, что это приведет к моему полному подчинению в отношениях и разрушит мою индивидуальность и независимость.', test_id: '1', for_yes_answer_plus_1_point_to: 'shl'
Question.create title: 'Я не сожалею, что все важные отношения в моей жизни были внезапно прерваны по моей инициативе.  Я не умею грустить, мне ничего не жаль. Я заводной и веселый, как детская игрушка «волчок».', test_id: '1', for_yes_answer_plus_1_point_to: 'gml'
Question.create title: 'Моё самоуважение повышается в борьбе против несправедливости, против врагов и властей. Я мог бы направить свои усилия служению жертвам плохого обращения, презираемым и угнетенным.', test_id: '1', for_yes_answer_plus_1_point_to: 'pl'
Question.create title: 'Я стремлюсь испытвать только позитивные чувства к тому, кого люблю. Я упрекаю себя, что недостаточно ценил партнера, выражал ему свою любовь и поддержку, и это привело к расставанию. Это мои плохие человеческие качества привели к потере любви. Улучшая свои внутренние качества, я смогу сохранять отношения. ', test_id: '1', for_yes_answer_plus_1_point_to: 'dl'
Question.create title: 'Мой партнер часто заставлял меня испытывать страдания, но я не уходил от него, потому  что я понимал, что иногда я заслуживаю плохое обращение. И он таким способом хочет меня научить чему-то важному, желая мне добра. Я благодарен ему за это.  Я стойко терплю плохое обращение и жертвую собой из опасения остаться в одиночестве.', test_id: '1', for_yes_answer_plus_1_point_to: 'ml'
Question.create title: 'Иногда, чтобы обезоружить потенциального обидчика и людей, чьего отвержения я опасаюсь, я становлюсь ребячливым и беспомощным. Иногда я очаровываю их из страха эксплуатации или отвержения.', test_id: '1', for_yes_answer_plus_1_point_to: 'il'
Question.create title: 'Мое умение обдумывать детали-это моя сильная сторона, но иногда это мешает мне принять решение, так как я осмысливаю каждую деталь в отдельности, опираясь при этом на логику и рациональность, но не охватывая явление целостно, упуская его суть. Поэтому то, что кому-то покажется малозначительной деталью по сравнению с целым, может заставить меня переменить  мое решение. ', test_id: '1', for_yes_answer_plus_1_point_to: 'ol'



Question.create title: 'Если бы я не опасался, что «задохнусь» в отношениях, то мог бы проявить колоссальные по силе и глубине чувства. Я могу быть очень заботливым. Но другие люди не могут оценить, увидеть и понять мои эмоциональные, интуитивные и чувственные возможности. Из-за такого эмоционального непонимания я бываю подавленным и ищу уединения. Многие считают меня безнадежным отшельником.', test_id: '1', for_yes_answer_plus_1_point_to: 'shl'
Question.create title: 'В мире много опасностей, жестокости, хаоса и угроз. Поэтому я всегда бдителен и проницателен, отслеживаю и разоблачаю признаки угрозы, чтоб противодействовать ей. Я не признаю «нежных эмоций», часто испытываю ярость. Для этого у меня достаточно причин. Я должен вступать в схватку и побеждать.', test_id: '1', for_yes_answer_plus_1_point_to: 'pl'
Question.create title: 'Я легко привлекаю к себе внимание окружающих, очаровываю и эмоционально привязываю. Но в ответ я не вхожу в близкий контакт, опасаясь не перенести печали в случае разрыва глубокой привязанности. Я опасаюсь зависимости от любимого человека  в том смысле, что я не вынесу боли разрыва, и что эти страдания разрушат меня.', test_id: '1', for_yes_answer_plus_1_point_to: 'gml'
Question.create title: 'Выражение злости на партнера может привести к разрыву, поэтому я  терпелив к недостаткам партнера, критикую себя и злюсь на себя, а не на него. Мой страх разрыва отношений снижается, если я направляю злость и критику на себя. Я верю, что если б я был лучше, то партнер дарил бы мне любовь и тепло. Я надеюсь на свое внутреннее самосовершенствование, это дает мне надежду на сохранение отношений. ', test_id: '1', for_yes_answer_plus_1_point_to: 'dl'
Question.create title: 'Я мужественно терплю свои несчастья, потому что страдания- это цена отношений. Любовь и жестокость всегда рядом. Лучше я буду страдать, чем останусь один. Я не позволяю себе действовать эгоистично, потакая своим желаниям. Это бы вызывало у меня чувстов вины.', test_id: '1', for_yes_answer_plus_1_point_to: 'ml'
Question.create title: 'Иногда я «выхожу» из себя, и тогда я «имею право на все». В эти моменты я абсолютно не помню, как оскорбил кого-то.', test_id: '1', for_yes_answer_plus_1_point_to: 'al'
Question.create title: 'Я предъявляю к себе суровые требования быть собранным, упорным, трудолюбивым. Я сам назначаю себе сроки, и сам составляю себе план работы. Мне хорошо знакомо чувство постоянного усилия и напряжения человека, которому нужно закончить работу в срок. Это ощущение меня никогда не покидает, но мне так спокойнее, мне это создает своеобразную структуру жизни, в которой я чувствую надежность и определенность.', test_id: '1', for_yes_answer_plus_1_point_to: 'ol'
Question.create title: 'Когда моя тревога становится слишком сильной, то я ищу облегчения в любовной истории, или заболеваю, или веду себя по-детски, ребячливо, потому что ощущаю себя маленьким пугливым ребенком.  Я считаю себя обделенным по причине принадлежности к своему полу.', test_id: '1', for_yes_answer_plus_1_point_to: 'il'
Question.create title: 'Я должен многое сделать, поэтому постоянно удерживаю фокус своего внимания на работе. Я знаю, что если я сделаю все правильно, то смогу контролировать результат. Я стараюсь быть организованным, умелым, ответственным. Я сожалею, если мой день проходит неэффективно, даже если это мой выходной. Я составляю иногда расписание и на выходные, чтоб получить максимум удовольствия, и расстраиваюсь, если что-то нарушает мое расписание. ', test_id: '1', for_yes_answer_plus_1_point_to: 'kl'
Question.create title: 'Я ставлю перед собой высокие, труднодостижимые цели и идеалы. У меня есть идеальное виденье того, какой должна быть моя жизнь. Это потому, что мне важно получать высокие оценки окружающих. Ведь от их оценок зависит, ощущаю ли я себя  королем или неудачником. Я боюсь, когда меня сравнивают с другими.', test_id: '1', for_yes_answer_plus_1_point_to: 'nl'



Question.create title: 'Мне легче признаться в крупных проступках, чем в мелких. Мелкие проступки - это признак слабости.', test_id: '1', for_yes_answer_plus_1_point_to: 'al'
Question.create title: 'Я живу в состоянии постоянного волевого напряжения и самоконтроля. Я сам себе как надзиратель. Мне иногда кажется, что позади меня сидит надсмотрщик, который мне отдает приказы, напоминает, подгоняет, чтоб я придерживался сроков. Поэтому я не чувствую себя свободным, но я все равно не хочу ослабить самоконтроль.', test_id: '1', for_yes_answer_plus_1_point_to: 'ol'
Question.create title: 'Я часто поступаю вопреки своему благополучию, чтоб сберечь отношения. Отношений без боли не бывает. Я часто чувствовал себя виноватым и покинутым, но я не заслужил этого. Я боюсь остаться в одиночестве, разлука вызывает у меня отчаянье, даже депрессию, я не могу есть, спать, вставать по утрам, но я хочу отношений больше, чем безопасности.', test_id: '1', for_yes_answer_plus_1_point_to: 'ml'
Question.create title: 'Я умею прекрасно развлекать, шутить, подражать, я хороший рассказчик и остряк. Могу говорить без остановки. Мне свойственна постоянная подвижность. Я всегда показываю, что у меня все хорошо. ', test_id: '1', for_yes_answer_plus_1_point_to: 'gml'
Question.create title: 'Я всегда ожидаю нападения. Поэтому я слежу за враждебными мотивами других людей и направляю свои усилия на провал их угрожающих мне замыслов. Я стараюсь распознать в поведении других их злые намерения в отношении меня, так как все, что происходит вокруг, имеет прямое отношение к моей личности.', test_id: '1', for_yes_answer_plus_1_point_to: 'pl'
Question.create title: 'Я всегда придерживаюсь заранее намеченного плана и не даю себе свернуть с этого пути. Из-за этого иногда меня иногда называют упрямым, тяжелым человеком, но я горжусь своей целенаправленностью и не меняю план. Также я считаю, что не думать о деле- это безрассудство. ', test_id: '1', for_yes_answer_plus_1_point_to: 'kl'
Question.create title: 'Я чувствую глубокое удовлетворение, когда я забочусь о близких. Оказание помощи другим помогает мне уменьшить своё чувство вины и моральной неполноценности, почувствовать самоуважение. Я ищу возможности помогать другим.  Я всегда откликаюсь, когда кто-то переживает горе, страдания. Мои заслуги ничего не стоят.', test_id: '1', for_yes_answer_plus_1_point_to: 'dl'
Question.create title: 'Я не сильно озабочен тем, прав я или нет с общепринятой точки зрения, и какое впечатление я произвожу. Я бываю преднамеренно оппозиционным, чтоб не сближаться с другим человеком. Так я ищу и создаю дистанцию в отношениях, чтоб сохранить свою эмоциональную отстраненность и безопасность. Но при этом страдаю от одиночества. Я и хочу близости  и боюсь ее.', test_id: '1', for_yes_answer_plus_1_point_to: 'shl'
Question.create title: 'Я не люблю просить, благодарить и раскаиваться, потому что это равносильно признанию моей личной несостоятельности и зависимости от других. Это ранит мое самолюбие, заставляя чувствовать презрение и отвращение к себе.', test_id: '1', for_yes_answer_plus_1_point_to: 'nl'
Question.create title: 'Я стремлюсь к общению, близости, но часто чувствую себя сексуально неудовлетворенным. Мои основные желания - безопасность и любовь. Я сердечный, эмоциональный и интуитивно-человечный. ', test_id: '1', for_yes_answer_plus_1_point_to: 'il'



Question.create title: 'Хитрость и скрытое воздействие на окружающих - признак силы. Мне нравится чувствовать себя сильным, нанося другим поражения и вскрывая их слабости.', test_id: '1', for_yes_answer_plus_1_point_to: 'al'
Question.create title: 'Я бываю разочарован, когда люди не понимают, как мне плохо, и с какой стойкостью я терплю страдания, плохое обращение, которого не заслуживаю, ради сохранения отношений. Я обречен быть неправильно понятым, недооцененным, но пусть лучше на меня нападают, чем не замечают меня.', test_id: '1', for_yes_answer_plus_1_point_to: 'ml'
Question.create title: 'Я не могу позволить  себе расслабиться, позволить себе прихоть, спонтанность. Моя воля доминирует над моими желаниями и управляет моими чувствами и импульсами, которые могли бы отвлечь меня и прервать мою целенаправленную деятельность, ослабить мою решимость, вмешавшись в то, что я должен делать. Меня невозможно отвлечь от работы. Чувства-это потакание своим слабостям, они отвлекают от дел, это помехи в работе.', test_id: '1', for_yes_answer_plus_1_point_to: 'ol'
Question.create title: 'Я часто чувствую себя неуязвимым, убежденным в успехе своих грандиозных планов. Я не могу замедлиться. У меня часто повышенное настроение. Я не умею грустить', test_id: '1', for_yes_answer_plus_1_point_to: 'gml'
Question.create title: 'Я воспринимаю эмоционально важные события своей жизни образно, а детали не запоминаю. Я познаю мир через впечатления.', test_id: '1', for_yes_answer_plus_1_point_to: 'il'
Question.create title: 'Я внимательно слежу за тем, насколько моя жизнь соответствует высоким стандартам. Я требую и добиваюсь совершенства от себя и от других. Без этого мое ощущение избранности меняется на ощущение ничтожности и несоответствия высоким стандартам.', test_id: '1', for_yes_answer_plus_1_point_to: 'nl'
Question.create title: 'Я чувствую себя неловко в обстоятельствах, которые дают глоток свободы: отпуск, выходные, праздники, т.к. я совершенно не представляю, что хочу делать и начинаю беспокоиться, как будто на меня навалилась новая неотложная задача, хотя я иногда жалуюсь на загруженность работой и обязанностями. Это ощущение загруженности меня никогда не покидает, но мне так спокойнее, мне это создает своеобразную структуру жизни, в которой я чувствую определенность.', test_id: '1', for_yes_answer_plus_1_point_to: 'kl'
Question.create title: 'Состояние одиночества и психологической дистанции для меня менее губительно, чем состояние тесной привязанности. Я не всегда признаю настоящее глубинное, эмоциональное значение для меня  какого-то события, ситуации или отношений, и что эти чувства для меня на самом деле означают.', test_id: '1', for_yes_answer_plus_1_point_to: 'shl'
Question.create title: 'Я опасаюсь, что мои чувства обладают разрушительной силой и могут разрушить близких мне людей. Я беспокоюсь, что мои злые мысли и чувства навредят им.', test_id: '1', for_yes_answer_plus_1_point_to: 'pl'
Question.create title: 'Я испытываю огромный страх, что меня покинут, и с ужасом ожидаю разлуки. Разлука — это доказательство моей  малоценности и вины. И доказательство того, что я недостоин любви. Ведь я недостаточно хорош, чтоб вхохновить привязанность и пробудить к себе любовь.  Мне трудно примириться с расставанием и одиночеством, даже если это не надолго.', test_id: '1', for_yes_answer_plus_1_point_to: 'dl'



  @count = 1
  Question.all.where(test_id: '1').each do |f|
    f.update_attribute :number_of_question, @count
    @count = @count + 1
  end

end

