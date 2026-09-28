// Barème partiel : total seulement. Sans effet hors interro, sans afficher-brm, ou sans
// brm ; en anglais (point décimal, pluriel dès que ce n'est pas 1).
#import "../../src/lib.typ": *
#maquette(mode-maquette: "interro", afficher-brm: "partiel")[
  #exercice(titre: "Partiel", brm: (2, (1, 1.5), 3))[
    + A
    + B
      + B1
      + B2
    + C
  ]
  #exercice(titre: "Sans points")[Pas de total.]
]
#maquette(afficher-brm: "complet")[
  #exercice(titre: "Mode exercices : aucun barème", brm: (2, 3))[
    + A
    + B
  ]
]
#maquette(mode-maquette: "interro")[
  #exercice(titre: "Interro sans afficher-brm : aucun barème", brm: (2, 3))[
    + A
    + B
  ]
]
#maquette(mode-maquette: "interro", afficher-brm: "complet", langue: "en")[
  #exercice(brm: (0.5, 1, 1.25))[
    + A
    + B
    + C
  ]
]
