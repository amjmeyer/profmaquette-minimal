// Un seyes dans le corps d'un corrigé (ex. : zone laissée pour refaire le
// calcul) : ne doit pas décaler la correspondance des seyes suivants.
#import "../../src/lib.typ": *
#maquette(mode-maquette: "interro", position-corriges: "apres-question")[
  #exercice[a) #seyes(2) b) #seyes(2) c) #seyes(2)]
  #corrige[Réponse a), avec une grille : #seyes(1)]
  #corrige[Réponse b).]
  #corrige[Réponse c).]
]
