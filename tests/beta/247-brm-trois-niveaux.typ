// Imbrication sur trois niveaux, et entrée tableau pour une question sans
// sous-questions (ignorée pour l'affichage, comptée dans le total).
#import "../../src/lib.typ": *
#maquette(mode-maquette: "interro", afficher-brm: "complet")[
  #exercice(titre: "Trois niveaux", brm: (1, ((0.5, 0.5), 2), 1))[
    + Premier.
    + Deuxième.
      + Deuxième a.
        + Deuxième a i.
        + Deuxième a ii.
      + Deuxième b.
    + Troisième.
  ]
  #exercice(titre: "Tableau sans sous-questions", brm: ((1, 1), 2))[
    + Pas de sous-question ici.
    + Normale.
  ]
]
