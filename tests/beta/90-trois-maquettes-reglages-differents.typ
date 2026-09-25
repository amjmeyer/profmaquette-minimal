#import "../../src/lib.typ": *
#maquette(liste-corriges: ())[
  #afficher-fdr
  #thematique[T]
  #exercice(entrainement: "https://a.b/0")[A] #solution[a]
  #exercice(route: false)[B] #solution[b]
]
#pagebreak()
#maquette(localisation-correction: "apres")[
  #afficher-fdr
  #thematique[T]
  #exercice(entrainement: "https://a.b/1")[A] #solution[a]
  #exercice(route: false)[B] #solution[b]
]
#pagebreak()
#maquette(localisation-correction: "fin")[
  #afficher-fdr
  #thematique[T]
  #exercice(entrainement: "https://a.b/2")[A] #solution[a]
  #exercice(route: false)[B] #solution[b]
]
#pagebreak()
