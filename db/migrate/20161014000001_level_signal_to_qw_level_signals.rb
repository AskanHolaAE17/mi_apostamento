class LevelSignalToQwLevelSignals < ActiveRecord::Migration


Question.all.where(test_id: '2').destroy_all
  
  
  
QwLevelSignal.create title: 'Я стараюсь в конфликтной ситуации сохранять психологическую стабильность, а после стресса вернуться мыслями в эту ситуацию, чтобы проанализировать взаимодействия с партнером и сделать выводы на будущее, постаравшись выработать в себе новые способы мышления, поведения и таким образом уменьшить свою негативную роль в появлении конфликтов.', 
                for_yes_answer_plus_1_point_to: 'ne', 
                number_of_question: '1',
                test_id: '2'

QwLevelSignal.create title: 'В трудных ситуациях смертельный страх, тревога, ужас, внутренняя сумятица и паника просто захватывают меня целиком, не давая возможности разобраться и принять решение, как выйти из этой ситуации. Порой мне хочется спрятаться или исчезнуть. Я бы очень хотел получать защищенность, поддержку и безопасность от партнера.', 
                for_yes_answer_plus_1_point_to: 'ps', 
                number_of_question: '2',
                test_id: '2'

QwLevelSignal.create title: 'Мои чувства к другому человеку могут колебаться, меняясь с «абсолютно хороший» на «абсолютно плохой» по нескольку раз в день. Чувства захватывают при этом меня целиком и полностью, заставляя моё сердце биться сильнее. Я не размениваюсь на полутона, я категоричен в своём мнении. Я всегда стремлюсь контролировать ситуацию.', 
                for_yes_answer_plus_1_point_to: 'po', 
                number_of_question: '3',
                test_id: '2'                
                
                
end

