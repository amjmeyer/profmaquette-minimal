// Seyes avant le premier exercice, corrigé avant tout exercice, puis seyes
// dans l'en-tête de page.
#import "../../src/lib.typ": *
#set page(header: seyes(0.5))
#maquette(mode-maquette: "interro", position-corriges: "apres-question")[
  #seyes(2)
  #corrige[Corrigé orphelin (ignoré).]
  #exercice[Question. #seyes(2)]
  #corrige[Réponse.]
]
