class AddInfoPersonalConsultsInPages < ActiveRecord::Migration


  Page.create page: 'personal_consults', title_tag: 'Персональная консультация', description_meta: 'Психолог. Консультации. Болезни часто связаны с душевными переживаниями', keywords_meta: 'болезни, психолог, депрессии, здоровье', em: 'бессонница, отношения', h2: 'Персональная консультация, болезни'


end

