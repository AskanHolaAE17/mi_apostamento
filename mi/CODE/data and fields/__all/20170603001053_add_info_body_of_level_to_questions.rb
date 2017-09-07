class AddInfoBodyOfLevelToQuestions < ActiveRecord::Migration

  
  
Question.create title: 'Я полностью понимаю свои эмоции, действия и их причины, я могу объяснить каждый свой шаг, поэтому меня считают последовательным, уравновешенным и предсказуемым человеком. Моё поведение никого не приводит в замешательство, не вызывает недоумения или шока.', for_yes_answer_plus_1_point_to: 'ne', test_id: '2'




Question.create title: 'Некоторые мои жизненные сложности в отношениях и в работе обусловлены моей собственной предрасположенностью создавать эти трудности и являются делом моих рук, а не чужих. Поэтому я хочу полностью понять свое психологическое устройство с целью достижения максимально возможного уровня роста и удовлетворения в любви и в работе.', for_yes_answer_plus_1_point_to: 'ne', test_id: '2'




Question.create title: 'Я не позволяю никому чувствовать своё превосходство и власть надо мной, давить на меня. Независимость - это самое важное для меня. Отношения - это борьба «кто кого». Для меня отношения в паре возможны только при условии идеальной ситуации, так как я очень требователен.', for_yes_answer_plus_1_point_to: 'po', test_id: '2'




Question.create title: 'Я полностью понимаю свои эмоции, действия и их причины, я могу объяснить каждый свой шаг, поэтому меня считают последовательным, уравновешенным и предсказуемым человеком. Моё поведение никого не приводит в замешательство, не вызывает недоумения или шока.', for_yes_answer_plus_1_point_to: 'ne', test_id: '2'




Question.create title: 'Я часто испытываю тревогу, связанную со страхом смерти. Во снах я часто вижу разрушения, иногда мне кажется, что я окончательно запутался. Иногда я боюсь сойти с ума. Иногда мне трудно понять, почему моё поведение приводит в замешательство других людей.', for_yes_answer_plus_1_point_to: 'ps', test_id: '2'




Question.create title: 'Мои чувства и эмоции захватывают меня целиком и не оставляют места сомнениям в моём понимании людей и ситуации: либо чёрное, либо белое. Я считаю своё понимание устройства людей и жизни правильным и не вижу причин его менять.', for_yes_answer_plus_1_point_to: 'po', test_id: '2'




Question.create title: '5	Некоторые мои жизненные сложности в отношениях и в работе обусловлены моей собственной предрасположенностью создавать эти трудности и являются делом моих рук, а не чужих. Поэтому я хочу полностью понять свое психологическое устройство с целью достижения максимально возможного уровня роста и удовлетворения в любви и в работе.', for_yes_answer_plus_1_point_to: 'ne', test_id: '2'




Question.create title: 'Я хочу, чтобы другие люди объясняли мне своё поведение и свои эмоции, а также суть происходящего, тогда мои страх и тревога уменьшаются. Без этого я чувствую страх и внутренний хаос. Иногда я реагирую на стресс уходом в мечтания, чтобы не чувствовать свой страх.', for_yes_answer_plus_1_point_to: 'ps', test_id: '2'




Question.create title: 'Счастье и любовь в одном браке на всю жизнь только в сказках бывает. От любви до ненависти и обратно - один шаг. Я в отношениях просто хочу перестать получать психологические травмы и хочу избавиться от критики. Партнеры заставляли меня испытывать обиду и боль за то, что критиковали и осуждали меня.', for_yes_answer_plus_1_point_to: 'po', test_id: '2'




Question.create title: 'Я не могу оставаться спокойным, когда рядом со мной раздраженный человек, ведь, скорее всего, он злится на меня, и я в опасности. Поэтому я хочу, чтобы более авторитетные люди обо мне заботились, защищали и успокаивали, когда у меня путаются мысли.', for_yes_answer_plus_1_point_to: 'ps', test_id: '2'




Question.create title: 'Я несу полную ответственность за свои эмоции и реакции. В любой стрессовой ситуации я в состоянии наблюдать за собой и контролировать свои слова и поступки. Поэтому я не поступаю таким способом, который бы противоречил моей целостной жизненной позиции и представлениям о себе.', for_yes_answer_plus_1_point_to: 'ne', test_id: '2'
  

    
  @questions = Question.all.where(test_id: '2')
  
  
  @count = 1
  @questions.each do |f|
    f.update_attribute :number_of_question, @count
    @count = @count + 1
  end
  
  
  
  @questions.find_by(number_of_question: '5').update_attribute :able, false
  @questions.find_by(number_of_question: '8').update_attribute :able, false

end

