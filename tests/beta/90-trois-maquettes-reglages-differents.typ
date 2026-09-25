#import "../../src/lib.typ": *
#maquette(liste-corriges: ())[
  #afficher-fdr
  #thematique[T]
  #exercice(entrainement: "https://a.b/0")[A] #corrige[a]
  #exercice(route: false)[B] #corrige[b]
]
#pagebreak()
#maquette(position-corriges: "apres")[
  #afficher-fdr
  #thematique[T]
  #exercice(entrainement: "https://a.b/1")[A] #corrige[a]
  #exercice(route: false)[B] #corrige[b]
]
#pagebreak()
#maquette(position-corriges: "fin")[
  #afficher-fdr
  #thematique[T]
  #exercice(entrainement: "https://a.b/2")[A] #corrige[a]
  #exercice(route: false)[B] #corrige[b]
]
#pagebreak()
