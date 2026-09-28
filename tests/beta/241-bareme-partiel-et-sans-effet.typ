// Barème partiel : total seulement. Sans effet hors interro, sans brm, ou sans
// points ; en anglais (point décimal, pluriel dès que ce n'est pas 1).
#import "../../src/lib.typ": *
#maquette(mode-maquette: "interro", brm: "partiel")[
  #exercice(titre: "Partiel", points: (2, (1, 1.5), 3))[
    + A
    + B
      + B1
      + B2
    + C
  ]
  #exercice(titre: "Sans points")[Pas de total.]
]
#maquette(brm: "complet")[
  #exercice(titre: "Mode exercices : aucun barème", points: (2, 3))[
    + A
    + B
  ]
]
#maquette(mode-maquette: "interro")[
  #exercice(titre: "Interro sans brm : aucun barème", points: (2, 3))[
    + A
    + B
  ]
]
#maquette(mode-maquette: "interro", brm: "complet", langue: "en")[
  #exercice(points: (0.5, 1, 1.25))[
    + A
    + B
    + C
  ]
]
