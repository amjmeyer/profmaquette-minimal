// Partiel + corrigés dans les seyes + sélection : exercice 2 non corrigé.
#import "../../src/lib.typ": *
#maquette(mode-maquette: "interro", afficher-brm: "partiel", position-corriges: "apres-question", liste-corriges: "1")[
  #exercice(brm: (1, 2))[
    + A #seyes(1)
    + B #seyes(1)
  ]
  #corrige[a]
  #corrige[b]
  #exercice(brm: 3)[
    + C #seyes(1)
  ]
  #corrige[NE DOIT PAS APPARAÎTRE]
]
