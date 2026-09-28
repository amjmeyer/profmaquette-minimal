// Titre très long (doit s'arrêter avant le total), calculatrice interdite,
// exercice hors route.
#import "../../src/lib.typ": *
#maquette(mode-maquette: "interro", afficher-brm: "complet")[
  #exercice(titre: "Un titre d'exercice vraiment très long, qui doit passer à la ligne sans jamais recouvrir le total", calculatrice: false, brm: (2, 3))[
    + A
    + B
  ]
  #exercice(titre: "Hors route", route: false, brm: 4)[Énoncé.]
]
