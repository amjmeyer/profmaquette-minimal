// Seyes plus haut qu'une page (40 carreaux = 32 cm), seul puis dans un exercice.
#import "../../src/lib.typ": *
#seyes(40)
#maquette(mode-maquette: "interro", position-corriges: "apres-question")[
  #exercice[Question. #seyes(40)]
  #corrige[Réponse.]
  #exercice[Question sans corrigé. #seyes(40)]
]
