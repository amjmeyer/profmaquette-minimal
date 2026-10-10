// seyes(…)[réponse] : grille par défaut, réponse avec afficher: true, dans
// et hors maquette, et mêlé au mode interro (la zone affichée compte dans
// le rang des #corrige : le 2e corrigé remplace bien la 3e zone).
#import "../../src/lib.typ": *

Hors maquette : #seyes(2)[Réponse cachée.]
#seyes(2, afficher: true)[Réponse affichée, hors maquette.]
#seyes(2, afficher: true)
#seyes(1, afficher: false, style: "sobre")[Toujours cachée.]

#maquette(mode-maquette: "interro", position-corriges: "apres-question")[
  #exercice[
    + Zone 1. #seyes(1)
    + Zone 2, réponse affichée. #seyes(1, afficher: true)[$2 + 2 = 4$.]
    + Zone 3. #seyes(1)
  ]
  #corrige[Corrigé de la zone 1.]
  #corrige[Corrigé de la zone 2 (ignoré : la zone affiche déjà sa réponse).]
  #corrige[Corrigé de la zone 3.]
]

#maquette[
  #exercice[
    Avec une couleur de corrigé par défaut :
    #seyes(2, afficher: true)[
      + Une liste,
      + des maths : $integral_0^1 x dif x = 1/2$.
    ]
  ]
]
