// Exercice plus haut qu'une page, barème complet, avec seyes : notes sur
// chaque page, cadre coupé.
#import "../../src/lib.typ": *
#maquette(mode-maquette: "interro", afficher-brm: "complet")[
  #exercice(titre: "Long", brm: (1, 1, 1, 1, 1, 1, 1, 1))[
    #for i in range(1, 9) [+ Question #i. #seyes(4)
    ]
  ]
]
