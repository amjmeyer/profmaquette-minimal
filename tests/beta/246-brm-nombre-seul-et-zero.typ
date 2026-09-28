// brm nombre seul en "complet" (total seulement, pas de note par question),
// brm à 0, décimales à arrondir (1/3), grand total.
#import "../../src/lib.typ": *
#maquette(mode-maquette: "interro", afficher-brm: "complet")[
  #exercice(titre: "Bloc", brm: 5)[
    + A
    + B
  ]
  #exercice(titre: "Zéro", brm: (0, 0))[
    + Question bonus
    + Autre bonus
  ]
  #exercice(titre: "Tiers", brm: (1/3, 2/3, 1))[
    + A
    + B
    + C
  ]
  #exercice(titre: "Grand total", brm: (40, 60.5))[
    + A
    + B
  ]
]
