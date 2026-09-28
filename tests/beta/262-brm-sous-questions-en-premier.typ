// Sous-questions dès la première question : brm ((1, 1), 1), structure avec
// lignes vides et sous-question vide ; question unique à sous-questions :
// ((1, 1),), avec la virgule finale (sans elle, ((1, 1)) vaut (1, 1)).
#import "../../src/lib.typ": *
#maquette(mode-maquette: "interro", afficher-brm: "complet")[
  #exercice(titre: "Sous-questions en premier", calculatrice: false, brm: ((1, 1), 1))[
    + On suppose que $x$ est un nombre réel vérifiant $4 < x < 9$.\

      + *Justifier rigoureusement* l'encadrement.

      +

    + Deuxième question.
  ]
  #exercice(titre: "Question unique à sous-questions", brm: ((1, 2),))[
    + Seule question.
      + Sous-question a.
      + Sous-question b.
  ]
]
