// Deux interros de suite : la seconde sans afficher-brm, rien ne fuit.
#import "../../src/lib.typ": *
#maquette(mode-maquette: "interro", afficher-brm: "complet")[
  #exercice(brm: (1, 2))[
    + A
    + B
  ]
]
#pagebreak()
#maquette(mode-maquette: "interro")[
  #exercice(brm: (1, 2))[
    + A
    + B
  ]
]
