// Barème avec feuille de route, thématiques, entraînement et source (icônes
// sur le filet droit, total en haut à droite).
#import "../../src/lib.typ": *
#maquette(mode-maquette: "interro", afficher-brm: "complet")[
  #align(center, afficher-fdr)
  #thematique[Suites]
  #exercice(titre: "Avec icônes", entrainement: "https://ctan.org", source: "Manuel p. 3", brm: (1, 1))[
    + A
    + B
  ]
  #thematique[Fonctions]
  #exercice(brm: 2, route: false)[Énoncé.]
]
