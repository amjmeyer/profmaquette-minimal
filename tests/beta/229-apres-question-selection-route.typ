// liste-corriges: "route" / "pas-route" avec apres-question.
#import "../../src/lib.typ": *
#maquette(mode-maquette: "interro", position-corriges: "apres-question", liste-corriges: "pas-route")[
  #exercice[Sur la route. #seyes(2)]
  #corrige[NE DOIT PAS APPARAÎTRE]
  #exercice(route: false)[Hors route. #seyes(2)]
  #corrige[Corrigé hors route (affiché).]
]
