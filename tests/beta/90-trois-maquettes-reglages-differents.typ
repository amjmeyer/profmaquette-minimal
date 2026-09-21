#import "../../src/lib.typ": *
#maquette(afficher-corrige: none)[
  #afficher-fdr
  #thematique[T]
  #exercice(entrainement: "https://a.b/0")[A] #solution[a]
  #exercice(obligatoire: false)[B] #solution[b]
]
#pagebreak()
#maquette(afficher-corrige: "apres")[
  #afficher-fdr
  #thematique[T]
  #exercice(entrainement: "https://a.b/1")[A] #solution[a]
  #exercice(obligatoire: false)[B] #solution[b]
]
#pagebreak()
#maquette(afficher-corrige: "fin")[
  #afficher-fdr
  #thematique[T]
  #exercice(entrainement: "https://a.b/2")[A] #solution[a]
  #exercice(obligatoire: false)[B] #solution[b]
]
#pagebreak()
