// Questions contenant des maths en display, un tableau et une figure.
#import "../../src/lib.typ": *
#maquette(mode-maquette: "interro", afficher-brm: "complet")[
  #exercice(titre: "Contenu riche", brm: (2, 1.5, 3))[
    + Résoudre $ integral_0^1 x^2 dif x = 1/3. $
    + Compléter le tableau.
      #table(columns: 3, [x], [0], [1], [f(x)], [], [])
    + Observer la figure.
      #figure(rect(width: 3cm, height: 1cm), caption: [Une figure.])
  ]
]
